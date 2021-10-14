//
//  ContentView.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/8/21.
//

import SwiftUI

struct RecipeListAppView: View {
    @ObservedObject private var recipeModel = RecipeModel.instance
    
    var body: some View {
        NavigationView {
            List(recipeModel.recipes) { recipe in
                NavigationLink {
                    DetailView(recipe: recipe)
                } label: {
                    HStack (spacing: 20) {
                        Image(recipe.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipped()
                            .cornerRadius(5)
                        
                        Text(recipe.name)
                            .font(.title2)
                    }
                }

            }.navigationTitle("All Recipes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListAppView()
    }
}
