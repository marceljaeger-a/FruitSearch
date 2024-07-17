//
//  CameraView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation
import SwiftUI
import AVFoundation
import UIKit

struct CameraView: View {
 
    @Binding var navPath: NavigationPath
    
    @State var isLoading: Bool = false
    
    @State var camera: Camera? = nil
    let predictionService = FoodPredictionService()
    
    @State var isPredicting = false
    @State var predictedFood: String = ""
    
    var buttonColor: AnyShapeStyle {
        camera?.latestImage == nil ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(Material.regular)
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
    
    var body: some View {
        Group {
            if let camera {
                CameraPreviewView(camera: camera)
                    .overlay(alignment: .bottom) {
                        ZStack {
                            FillShapeView(shape: .rect, style: buttonColor, fillStyle: .init(), background: Color.clear)
                                .layoutPriority(0)
                            
                            Group {
                                if let image = camera.latestImage {
                                    VStack(spacing: 15) {
                                        HStack {
                                            Spacer()
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
                                        
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            
                                            .clipShape(.containerRelative)
                                        
                                        Text(predictedFood)
                                            .font(.title)
                                            .bold()
                                        
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
                                } else {
                                    Button {
                                        camera.take()
                                    } label: {
                                        Image(systemName: "camera.shutter.button.fill")
                                            .foregroundStyle(.background)
                                            .font(.largeTitle)
                                    }
                                    .controlSize(.extraLarge)
                                }
                            }
                            .padding()
                            .layoutPriority(1)
                        }
                        .clipShape(.containerRelative)
                        .containerShape(.rect(cornerRadius: 25))
                        .padding()
                        .animation(.bouncy, value: camera.latestImage)
                    }
                    .task(id: camera.latestImage) {
                        if let image = camera.latestImage {
                            isPredicting = true
                            do {
                                predictedFood = try predictionService.predictFruit(in: image)
                            } catch {
                                print("Prediction failed")
                            }
                            isPredicting = false
                        }else {
                            predictedFood = ""
                        }
                    }
                    .task {
                        do {
                            try await camera.startPreview()
                        } catch {
                            print("No Authorization")
                        }
                    }
            }else {
                ContentUnavailableView("Loading camera is failed", systemImage: "camera")
            }
        }
        .onAppear {
            if camera == nil {
                do {
                    self.camera = try Camera()
                } catch CameraError.invalidDevice {
                    print("Invalid Device")
                } catch CameraError.invalidOutput {
                    print("Invalid Output")
                } catch CameraError.invalidInput {
                    print("Invalid Input")
                } catch {
                    print("Unknown Error")
                }
            }
        }
    }
}



//#Preview {
//    CameraView()
//}

