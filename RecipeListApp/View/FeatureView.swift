//
//  FeatureView.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/18/21.
//

import SwiftUI

struct FeatureView: View {
    @EnvironmentObject private var recipeModel: RecipeModel
    @State var presentDetailedView = false
    @State var tabSelectionIndex = 0
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            // MARK: Title
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding()
                .font(Font.custom("Avenir Heavy", size: 24))
            
            // MARK: Dish Card
            GeometryReader { geo in
                TabView(selection: $tabSelectionIndex) {
                    ForEach (0 ..< recipeModel.recipes.count) { index in
                        let recipe = recipeModel.recipes[index]
                        // Only show featured recipe(s)
                        if recipe.featured {
                            // Define our own faded black shadow
                            let shadowColor = Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5)
                            
                            // Button to pull up recipe for featured view
                            Button(action: {
                                // Presents the detailed view of this recipe
                                self.presentDetailedView = true
                            }) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                    
                                    VStack (spacing: 0) {
                                        Image(recipe.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(recipe.name)
                                            .padding(5)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width/8*7, height: geo.size.height - 100)
                            .cornerRadius(15)
                            .shadow(color: shadowColor, radius: 10, x: -5, y: 5)
                            .sheet(isPresented: $presentDetailedView) {
                                DetailView(recipe: recipe)
                            }
                            .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            // MARK: Prep Time and Highlights
            VStack (alignment: .leading, spacing: 10) {
                // Current tabSelectionIndex tells us which recipe is currently
                // presented.
                let currentRecipe = recipeModel.recipes[tabSelectionIndex]
                Text("Preparation Time:")
                    .font(Font.custom("Avenir Heavy", size: 16))
                Text(currentRecipe.prepTime)
                    .font(Font.custom("Avenir", size: 16))
                
                Text("Highlights:")
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlightsView(highlightsArray: currentRecipe.highlights)
            }
            .padding([.leading, .bottom])
        }
        .onAppear(perform: firstFeaturedIndex)
    }
    
    func firstFeaturedIndex() {
        let index = recipeModel.recipes.firstIndex { (recipe) -> Bool in
            return recipe.featured
        }
        
        tabSelectionIndex = index ?? 0
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        // Added for testing data
        let recipeModel = RecipeModel.instance
        
        FeatureView()
            .environmentObject(recipeModel)
    }
}
