//
//  CameraError.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import Foundation

enum CameraError: Error {
    case invalidDevice
    case invalidInput
    case invalidOutput
    case noAuthorization
}
