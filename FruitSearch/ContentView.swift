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
    
    var body: some View {
        NavigationStack(path: $navPath) {
           CameraView(navPath: $navPath)
                .navigationDestination(for: FoodProductList.self) { list in
                    FoodProductListView(list: list)
                }
        }
    }
}


#Preview {
    ContentView()
}
