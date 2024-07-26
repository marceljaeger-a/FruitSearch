//
//  FoodPredictionNutrientsView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 24.07.24.
//

import Foundation
import SwiftUI
import Charts

struct NutrientsView: View {
    
    //MARK: - Dependencies
    
    let nutrients: Nutrients
    
    @State var showMore = false
    
    //MARK: - Methods
    
    
    
    //MARK: - Body
    
    var body: some View {
        GroupBox {
            VStack(spacing: 25) {
                HStack {
                    MakroChart(calories: nutrients.calories, protein: nutrients.protein, carbs: nutrients.carbs, fat: nutrients.fat)
                    VStack(alignment: .leading){
                        Text("\(nutrients.protein.formatted())g protein")
                            .foregroundStyle(.blue)
                        Text("\(nutrients.carbs.formatted())g Carbs")
                            .foregroundStyle(.orange)
                        Text("\(nutrients.fat.formatted())g Fat")
                            .foregroundStyle(.red)
                    }
                    .font(.callout)
                    .bold()
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        showMore.toggle()
                    } label: {
                        Label("Show more", systemImage: "i.circle")
                    }
                }
                
//                if showMore {
//                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15, content: {
//                        ForEach(nutrients.all.filter { ["protein", "fat", "carbs"].contains($0.0) == false }, id: \.0) { nutrient in
//                            NutrientGridItem(value: nutrient.1, name: nutrient.0)
//                        }
//                    })
//                    
//                    Button {
//                        showMore.toggle()
//                    } label: {
//                        Text("Show less")
//                    }
//                }
            }
            .transaction(value: showMore, { transaction in
                if showMore {
                    transaction.animation = .smooth.delay(0.3)
                }else {
                    transaction.animation = nil
                }
            })
        } label: {
            Text("Nutrients")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .sheet(isPresented: $showMore, content: {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 15, pinnedViews: .sectionHeaders, content: {
                    Section("Nutrients") {
                        ForEach(nutrients.all.filter { ["protein", "fat", "carbs"].contains($0.0) == false }, id: \.0) { nutrient in
                            NutrientGridItem(value: nutrient.1, name: nutrient.0)
                        }
                    }
                })
            }
            .contentMargins(25)
            .overlay(alignment: .topTrailing) {
                Button {
                    showMore.toggle()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .padding()
            }
            .presentationContentInteraction(.scrolls)
        })
        .padding(.bottom)
        .padding()
        .geometryGroup()
        .animation(.smooth, value: showMore)
    }
}

struct NutrientGridItem: View {
    let value: Double
    let name: String
    
    var body: some View {
        Text("\(value.formatted())g")
            .font(.callout)
        Text(name)
            .font(.callout)
            .foregroundStyle(.secondary)
    }
}

struct MakroChart: View {
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
    
    var proteinCalories: Double {
        protein * 4
    }
    var carbsCalories: Double {
        carbs * 4
    }
    var fatCalories: Double {
        fat * 9
    }
    
    var body: some View {
        Chart {
            SectorMark(angle: .value("Protein", proteinCalories), innerRadius: .ratio(0.5), angularInset: 2)
                .foregroundStyle(.blue)
            
            SectorMark(angle: .value("Carbs", carbsCalories), innerRadius: .ratio(0.5), angularInset: 2)
                .foregroundStyle(.orange)
            
            SectorMark(angle: .value("Fat", fatCalories), innerRadius: .ratio(0.5), angularInset: 2)
                .foregroundStyle(.red)
        }
        .frame(height: 150)
        .overlay {
            Text("\(calories.formatted()) kcal")
                .font(.callout)
                .bold()
        }
    }
}

#Preview {
    NutrientsView(nutrients: .apple)
}
