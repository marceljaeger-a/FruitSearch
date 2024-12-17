//
//  CameraPreview.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation
import UIKit
import AVFoundation
import SwiftUI

struct CameraPreviewView: UIViewRepresentable {
    let camera: Camera
    
    func makeUIView(context: Context) -> some UIView {
        let preview = UICameraPreview()
        preview.videoPreviewLayer.session = camera.session
        preview.videoPreviewLayer.videoGravity = .resizeAspect
        return preview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

fileprivate class UICameraPreview: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
