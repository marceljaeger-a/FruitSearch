//
//  IntelligentTakePhotoButton.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 17.07.24.
//

import Foundation
import SwiftUI

struct IntelligentTakePhotoButton : View {
    let camera: Camera
    @Binding var navPath: NavigationPath
    
    @State var predictedFood: String = ""
    @State var isPredicting = false
    @State var isLoading: Bool = false
    
    let predictionService = FoodPredictionService()
    
    var modalColor: AnyShapeStyle {
        camera.latestImage == nil ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(Material.regular)
    }
    
    var modalshape: AnyShape {
        camera.latestImage == nil ? AnyShape(.circle) : AnyShape(.containerRelative)
    }
    
    private func loadFoodPruducts() async {
        isLoading = true
        do {
            let service = OpenFoodFactsService()
            let list = try await service.fetchList(searchBy: predictedFood)
            isLoading = false
            navPath.append(list)
        }catch OpenFoodFactsError.invalidURL {
            print("Invalid URL")
        } catch OpenFoodFactsError.invalidRespsone {
            print("Invalid Response")
        } catch OpenFoodFactsError.invlaidData {
            print("Invalid Data")
        } catch {
            print("Unknown Error")
        }
        isLoading = false
    }
    
    private func predictFood() async {
        if let image = camera.latestImage {
            isPredicting = true
            do {
                predictedFood = try await predictionService.predictFruit(in: image)
            } catch {
                print("Prediction failed")
            }
            isPredicting = false
        }else {
            predictedFood = ""
        }
    }
    
    var body: some View {
        Group {
            if let image = camera.latestImage {
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        deletePhotoButton
                    }
                    
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .clipShape(.containerRelative)

                    Text(predictedFood)
                        .font(.title)
                        .bold()
                    
                    loadFoodProductsButton
                }
                .padding()
            } else {
                TakePhotoButton(camera: camera)
            }
        }
        .background(modalColor, in: .rect)
        .clipShape(modalshape)
        .containerShape(.rect(cornerRadius: 25))
        .padding()
        .transaction(value: camera.latestImage, { transaction in
            if camera.latestImage == nil {
                transaction.animation = .smooth
            }else {
                transaction.animation = .bouncy
            }
        })
        .task(id: camera.latestImage) {
            await predictFood()
        }
    }
    
    var loadFoodProductsButton: some View {
        Button {
            Task {
                await loadFoodPruducts()
            }
        } label: {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }else {
                Text("Show products")
            }
        }
        .disabled(isLoading)
    }
    
    var deletePhotoButton: some View {
        Button {
            camera.latestCGImage = nil
            print("Debug")
        } label: {
            Image(systemName: "xmark")
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .controlSize(.large)
    }
}


struct TakePhotoButton : View {
    let camera: Camera
    
    var body: some View {
        Button {
            Task {
                await camera.take()
            }
        } label: {
            Image(systemName: "camera.shutter.button.fill")
                .foregroundStyle(.background)
                .font(.title2)
                .padding(25)
        }
    }
}
