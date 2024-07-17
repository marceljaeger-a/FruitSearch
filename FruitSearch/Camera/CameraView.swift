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
    
    @State var camera: Camera? = nil
    
    var body: some View {
        Group {
            if let camera {
                CameraPreviewView(camera: camera)
                    .ignoresSafeArea(edges: .vertical)
                    .overlay(alignment: .bottom) {
                        IntelligentTakePhotoButton(camera: camera, navPath: $navPath)
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

