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
    
    @State var predictedFood: FoodPrediction? = nil
    @State var isPredicting = false
    
    let predictionService = FoodPredictionService()
    
    var modalColor: AnyShapeStyle {
        camera.latestImage == nil ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(Material.regular)
    }
    
    var modalshape: AnyShape {
        camera.latestImage == nil ? AnyShape(.circle) : AnyShape(.containerRelative)
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
            predictedFood = nil
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let image = camera.latestImage {
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        deletePhotoButton
                    }
                    
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.containerRelative)
                        .frame(width: 300)
                        
                    
                    if let predictedFood {
                        Label(predictedFood.name, systemImage: "sparkles")
                            .font(.title)
                            .bold()
                        
                        loadFoodProductsButton
                    }else {
                        Text("Not identifiable!")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
            
            TakePhotoButton(camera: camera)
                .opacity(camera.latestImage == nil ? 1.0 : 0.0)
                .transaction(value: camera.latestImage) { transaction in
                    if camera.latestImage == nil {
                        transaction.animation = .smooth.delay(0.3)
                    }else {
                        transaction.animation = nil
                    }
                    
                }
        }
        .transaction(value: camera.latestImage) { transaction in
            if camera.latestImage == nil {
                transaction.animation = nil
            }else {
                transaction.animation = .smooth.delay(0.3)
            }
            
        }
        .background(modalColor.shadow(.drop(radius: 5)), in: modalshape)
        .containerShape(.rect(cornerRadius: 25))
        .padding()
        .transaction(value: camera.latestImage, { transaction in
            if camera.latestImage == nil {
                transaction.animation = .bouncy
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
            if let predictedFood {
                navPath.append(predictedFood)
            }
        } label: {
            Text("Show details")
        }
    }
    
    var deletePhotoButton: some View {
        Button {
            camera.latestCGImage = nil
        } label: {
            Image(systemName: "xmark")
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
        .controlSize(.regular)
    }
}


struct TakePhotoButton : View {
    let camera: Camera
    
    @State var isTakingPhoto: Bool = false
    
    var body: some View {
        Button {
            Task {
                isTakingPhoto.toggle()
                await camera.take()
            }
        } label: {
            Image(systemName: "camera.shutter.button.fill")
                .foregroundStyle(.background)
                .font(.title2)
                .symbolEffect(.bounce, value: isTakingPhoto)
                .sensoryFeedback(.impact, trigger: isTakingPhoto)
                .padding(25)
        }
    }
}
