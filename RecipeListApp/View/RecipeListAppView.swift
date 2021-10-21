//
//  ContentView.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/8/21.
//

import SwiftUI

struct RecipeListAppView: View {
    @EnvironmentObject private var recipeModel: RecipeModel
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 0) {
                Text("All Recipes")
                    .bold()
                    .padding(.vertical, 25)
                    .font(.largeTitle)
                
                ScrollView {
                    LazyVStack (alignment: .leading) {
                        ForEach(recipeModel.recipes) { recipe in
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
                                    
                                    VStack (alignment: .leading) {
                                        Text(recipe.name)
                                            .font(.title2)
                                            .foregroundColor(.black)
                                        
                                        RecipeHighlightsView(highlightsArray: recipe.highlights)
                                            .foregroundColor(.black)
                                            .font(.footnote)
                                    }
                                }
                            }
                        }
                    }                }
            }
            // Suppress bar title for consistent titles across views
            .navigationBarHidden(true)
            .padding(.leading)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Added for testing data
        let recipeModel = RecipeModel.instance
        
        RecipeListAppView()
            .environmentObject(recipeModel)
    }
}
