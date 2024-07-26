//
//  ContentView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import SwiftUI
import PhotosUI
import CoreML

struct ContentView: View {
    @State var navPath: NavigationPath = .init()
    @State var camera: Camera? = nil
    
    var body: some View {
        NavigationStack(path: $navPath) {
            CameraView(camera: $camera)
                .overlay(alignment: .bottom) {
                    if let camera {
                        IntelligentTakePhotoButton(camera: camera, navPath: $navPath)
                    }
                }
                .navigationDestination(for: FoodPrediction.self) { prediction in
                    FoodPredictionDetailView(prediction: prediction)
                }
        }
    }
}


#Preview {
    ContentView()
}
