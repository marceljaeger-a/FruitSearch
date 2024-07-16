//
//  ContentView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 16.07.24.
//

import SwiftUI

struct ContentView: View {
    @State var list: FoodProductList?
    @State var isLoading: Bool = false
    
    private func loadFoodPruducts() async {
        isLoading = true
        do {
            let service = OpenFoodFactsService()
            list = try await service.fetchList(searchBy: "Avocado")
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
        NavigationStack {
            FoodProductListView(list: list)
                .overlay {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            Task {
                                await loadFoodPruducts()
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
