//
//  SelectPhotoView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation
import SwiftUI
import PhotosUI

struct SelectPhotoView: View {
    @State var isPhotoPickerShown = false
    @State var selectedPickerItem: PhotosPickerItem? = nil
    
    @State var selectedImage: Image? = nil
    @State var fruit: String = "No fruit"
    
    func loadImage() async {
        guard let selectedPickerItem else {
            return
        }
        
        selectedPickerItem.loadTransferable(type: Image.self) { result in
            do {
                selectedImage = try result.get()
            } catch {
                print("Error")
            }
        }
    }
    
    var body: some View {
        VStack {
            if let selectedImage {
                VStack {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .onAppear {
                            Task {
                                let service = FoodPredictionService()
                                do {
                                    fruit = try service.predictFruit(in: selectedImage)
                                } catch FoodPredictionError.invalidImage {
                                    print("Invalid image")
                                } catch FoodPredictionError.failedPrediction {
                                    print("Failed Prediction")
                                }
                                
                            }
                        }
                    
                    Text(fruit)
                }
            }else {
                Text("Selected Image")
                Button {
                    isPhotoPickerShown.toggle()
                } label: {
                    Text("Open picker")
                }
            }
        }
        .photosPicker(isPresented: $isPhotoPickerShown, selection: $selectedPickerItem)
        .photosPickerStyle(.inline)
        .task(id: selectedPickerItem) {
            await loadImage()
        }
    }
}
