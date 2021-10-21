//
//  DetailView.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/13/21.
//

import SwiftUI

struct DetailView: View {
    
    var recipe: Recipe
    
    @State var servingSizeTag = 2
    var servingSizeOptions = [2, 4, 6, 8]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFit()
                
                // MARK: Servings Picker
                VStack (alignment: .leading) {
                    Text("Select your serving size:")
                        .font(.callout)
                    Picker("Serving Size", selection: $servingSizeTag) {
                        ForEach(servingSizeOptions, id: \.self) { servingSize in
                            Text(String(servingSize)).tag(servingSize)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 175)
                }
                .padding()
                
                // MARK: Ingredients
                VStack (alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(recipe.ingredients) { ingredient in
                        HStack (alignment: .top) {
                            // TODO: Work amounts / units back into display
                            let portion = RecipeModel.getPortion(ingredient: ingredient, recipeServings: recipe.servings, targetServings: servingSizeTag)
                            
                            Text("• ")
                            Text("\(portion) \(ingredient.name.lowercased())")
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                Divider()
                
                // MARK: Directions
                VStack (alignment: .leading) {
                    Text("Directions")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(0 ..< recipe.directions.count, id: \.self) { index in
                        HStack(alignment: .top) {
                            let direction = recipe.directions[index]
                            Text("\(index+1): ")
                            Text(direction)
                        }
                        .padding(.bottom, 5)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .navigationTitle(recipe.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy recipe and pass into DetailView for preview
        let model = RecipeModel.instance
        DetailView(recipe: model.recipes[0])
    }
}
