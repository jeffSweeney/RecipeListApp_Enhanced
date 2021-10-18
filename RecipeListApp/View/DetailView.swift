//
//  DetailView.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/13/21.
//

import SwiftUI

struct DetailView: View {
    
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFit()
                
                // MARK: Ingredients
                VStack (alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(recipe.ingredients) { ingredient in
                        HStack (alignment: .top) {
                            // TODO: Work amounts / units back into display
                            Text("• ")
                            Text(ingredient.name)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                // MARK: Divider
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
