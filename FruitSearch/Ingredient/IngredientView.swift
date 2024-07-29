//
//  IngredientView.swift
//  FruitSearch
//
//  Created by Marcel Jäger on 27.07.24.
//

import Foundation
import SwiftUI

struct IngredientView: View {
    let image: Image
    let ingredient: Ingredient
    
    @State var selectedPortion: Ingredient.WeightPerServing
    
    init(image: Image, ingredient: Ingredient) {
        self.image = image
        self.ingredient = ingredient
        self.selectedPortion = ingredient.nutrition.weightPerServing
    }
    
    var proteinColor: AnyShapeStyle{
        let sortedNutrients = [ingredient.nutrition.protein, ingredient.nutrition.carbohydrate, ingredient.nutrition.fat].sorted(using: KeyPathComparator(\.amount, order: .reverse))
        
        var counter = 0
        for nutrient in sortedNutrients {
            if ingredient.nutrition.protein.name == nutrient.name {
                break
            }
            counter += 1
        }
        
        switch counter {
        case 0:
            return AnyShapeStyle(.accent)
        case 1:
            return AnyShapeStyle(.secondAccent)
        default:
            return AnyShapeStyle(.thirdAccent)
        }
    }
    
    var carbsColor: AnyShapeStyle{
        let sortedNutrients = [ingredient.nutrition.protein, ingredient.nutrition.carbohydrate, ingredient.nutrition.fat].sorted(using: KeyPathComparator(\.amount, order: .reverse))
        
        var counter = 0
        for nutrient in sortedNutrients {
            if ingredient.nutrition.carbohydrate.name == nutrient.name {
                break
            }
            counter += 1
        }
        
        switch counter {
        case 0:
            return AnyShapeStyle(.accent)
        case 1:
            return AnyShapeStyle(.secondAccent)
        default:
            return AnyShapeStyle(.thirdAccent)
        }
    }
    
    var fatColor: AnyShapeStyle{
        let sortedNutrients = [ingredient.nutrition.protein, ingredient.nutrition.carbohydrate, ingredient.nutrition.fat].sorted(using: KeyPathComparator(\.amount, order: .reverse))
        
        var counter = 0
        for nutrient in sortedNutrients {
            if ingredient.nutrition.fat.name == nutrient.name {
                break
            }
            counter += 1
        }
        
        switch counter {
        case 0:
            return AnyShapeStyle(.accent)
        case 1:
            return AnyShapeStyle(.secondAccent)
        default:
            return AnyShapeStyle(.thirdAccent)
        }
    }
    
    var body: some View {
//        ScrollView {
//            VStack(spacing: 10) {
//
//                GroupBox("") {
//                    HStack {
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
//                            .clipShape(.rect(cornerRadius: 10))
//                            .shadow(radius: 3)
//                        
//                        Picker("", selection: $selectedPortion) {
//                            Text("\(ingredient.nutrition.weightPerServing.amount.nutrientFormatted()) \(ingredient.nutrition.weightPerServing.unit)")
//                                .tag(ingredient.nutrition.weightPerServing)
//                            
//                            if ingredient.nutrition.weightPerServing.amount != 100 {
//                                Text("100 g")
//                                    .tag(ingredient.nutrition.weightPerServing.with(amount: 100))
//                            }
//                        }
//                        .pickerStyle(.wheel)
//                        .frame(height: 125)
//                    }
//                }
//                .backgroundStyle(.regularMaterial)
//                .padding(10)
//                .containerRelativeFrame(.horizontal, count: 2, span: 2, spacing: 0)
//                
//                GroupBox("Macros") {
//                    MakroNutrientsChart(
//                        protein: ingredient.nutrition.protein.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion),
//                        carbs: ingredient.nutrition.carbohydrate.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion),
//                        fat: ingredient.nutrition.fat.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion)
//                    )
//                    .scaledToFit()
//                    .shadow(radius: 3)
//                    .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
//                    .overlay {
//                        VStack {
//                            Text("\(ingredient.nutrition.calories.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.formatted())")
//                                .bold()
//                            Text("\(ingredient.nutrition.calories.unit)")
//                        }
//                    }
//                    
//                    Spacer(minLength: 25)
//                    
//                    Grid(horizontalSpacing: 25) {
//                        GridRow {
//                            Text("Protein")
//                                .foregroundStyle(proteinColor)
//                            
//                            Text("Carbs")
//                                .foregroundStyle(carbsColor)
//                            
//                            Text("Fat")
//                                .foregroundStyle(fatColor)
//                        }
//                        GridRow {
//                            Text("\(ingredient.nutrition.protein.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.protein.unit)")
//                                .bold()
//                            
//                            Text("\(ingredient.nutrition.carbohydrate.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.carbohydrate.unit)")
//                                .bold()
//                            
//                            Text("\(ingredient.nutrition.fat.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.fat.unit)")
//                                .bold()
//                        }
//                    }
//                    
//                        
//                        
//                }
//                .backgroundStyle(.regularMaterial)
//                .padding(10)
//                .containerRelativeFrame(.horizontal, count: 2, span: 2, spacing: 0)
//                
//                GroupBox("Nutrients") {
//                    NutrientListView(nutrients: ingredient.nutrition.nutrients.sorted(using: KeyPathComparator(\.name)).map{ $0.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion) })
//                }
//                .backgroundStyle(.regularMaterial)
//                .padding(10)
//                .containerRelativeFrame(.horizontal, count: 2, span: 2, spacing: 0)
//                
//
//            }
//        }
//        .contentMargins(20)
        
        Form {
            Section {
                HStack {
                    Spacer()
                    VStack {
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(.buttonBorder)
                            .shadow(radius: 3)
                            .containerRelativeFrame(.horizontal, count: 3, span: 2, spacing: 0)
                        
                        Text(ingredient.name.uppercasedFirst())
                            .font(.largeTitle)
                            .bold()
                    }
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
            
            Section("Serving") {
                Picker("Amount", selection: $selectedPortion) {
                    Text("\(ingredient.nutrition.weightPerServing.amount.nutrientFormatted()) \(ingredient.nutrition.weightPerServing.unit)")
                        .tag(ingredient.nutrition.weightPerServing)
                    
                    if ingredient.nutrition.weightPerServing.amount != 100 {
                        Text("100 g")
                            .tag(ingredient.nutrition.weightPerServing.with(amount: 100))
                    }
                }
                .pickerStyle(.navigationLink)
            }
            
            Section("Macros") {
                HStack {
                    MakroNutrientsChart(
                        protein: ingredient.nutrition.protein.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion),
                        carbs: ingredient.nutrition.carbohydrate.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion),
                        fat: ingredient.nutrition.fat.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion)
                    )
                    .scaledToFit()
                    .shadow(radius: 3)
                    .containerRelativeFrame(.horizontal, count: 2, span: 1, spacing: 0)
                    .overlay {
                        VStack {
                            Text("\(ingredient.nutrition.calories.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.formatted())")
                                .bold()
                            Text("\(ingredient.nutrition.calories.unit)")
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        VStack {
                            Text("Protein")
                                .foregroundStyle(proteinColor)
                            Text("\(ingredient.nutrition.protein.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.protein.unit)")
                                .bold()
                        }
                        
                        VStack {
                            Text("Carbs")
                                .foregroundStyle(carbsColor)
                            Text("\(ingredient.nutrition.carbohydrate.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.carbohydrate.unit)")
                                .bold()
                        }
                        
                        VStack {
                            Text("Fat")
                                .foregroundStyle(fatColor)
                            Text("\(ingredient.nutrition.fat.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion).amount.nutrientFormatted())\(ingredient.nutrition.fat.unit)")
                                .bold()
                        }
                    }
                    
                    Spacer()
                }
            }
            
            Section("Nutrients") {
                NutrientListView(nutrients: ingredient.nutrition.nutrients.filter { $0.name != "Calories" }.sorted(using: KeyPathComparator(\.name)).map{ $0.transform(from: ingredient.nutrition.weightPerServing, to: selectedPortion) })
            }
        }
    }
}


#Preview {
    IngredientView(image: .init(systemName: "cup.and.saucer.fill"), ingredient: .init(id: 0, original: "", originalName: "", name: "Apple", amount: 1, unit: "piece", unitShort: "p", unitLong: "piece", possibleUnits: [], estimatedCost: .init(value: 20, unit: "euroe"), consistency: "", shoppingListUnits: [], aisle: "", image: "", nutrition: .init(nutrients: [], properties: [], flavonoids: [], caloricBreakdown: .init(percentProtein: 30, percentFat: 30, percentCarbs: 40), weightPerServing: .init(amount: 150, unit: "g")), categoryPath: []))
}


extension String {
    func uppercasedFirst() -> String {
        var value = self
        
        guard value.count > 0 else { return self }
        let firstChar = value.removeFirst()
        var newString = ""
        newString.append(firstChar.uppercased())
        newString.append(value)
        return newString
    }
}
