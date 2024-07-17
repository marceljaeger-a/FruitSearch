//
//  Camera.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation
import AVFoundation
import SwiftUI



@Observable
class Camera: NSObject, AVCapturePhotoCaptureDelegate {
    let session: AVCaptureSession
    let output: AVCapturePhotoOutput
    let input: AVCaptureInput
    
    var latestCGImage: CGImage?
    
    var latestImage: Image? {
        get {
            if let latestCGImage {
                let uiImage = UIImage(cgImage: latestCGImage, scale: 1, orientation: .right)
                return Image(uiImage: uiImage)
            }
            return nil
        }
    }
    
    init(device: AVCaptureDevice? = .default(for: .video)) throws {
        let session = AVCaptureSession()
        let device = AVCaptureDevice.default(for: .video)
        
        guard let device else {
            throw CameraError.invalidDevice
        }
        
        let input = try? AVCaptureDeviceInput(device: device)
        guard let input, session.canAddInput(input) else {
            throw CameraError.invalidInput
        }
        session.addInput(input)
        
        let output = AVCapturePhotoOutput()
        guard session.canAddOutput(output) else {
            throw CameraError.invalidOutput
        }
        
        session.sessionPreset = .photo
        session.addOutput(output)
        session.commitConfiguration()
        
        self.session = session
        self.output = output
        self.input = input
        
        super.init()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        if error != nil {
            print("PhotoCapture failed")
        }
        
        if let image = photo.cgImageRepresentation() {
            self.latestCGImage = image
        }
    }
    
    func startPreview() async throws {
        guard await hasAuthorization() else {
            throw CameraError.noAuthorization
        }
        
        if session.isRunning == false {
            session.startRunning()
        }
    }
    
    func stopPreview() async throws {
        guard await hasAuthorization() else {
            throw CameraError.noAuthorization
        }
        
        if session.isRunning == true {
            session.stopRunning()
        }
    }
    
    func hasAuthorization() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        // Determine whether a person previously authorized camera access.
        var isAuthorized = status == .authorized
        // If the system hasn't determined their authorization status,
        // explicitly prompt them for approval.
        if status == .notDetermined {
            isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
        }
        
        return isAuthorized
    }
    
    func take() {
        output.capturePhoto(with: .init(), delegate: self)
    }
}
