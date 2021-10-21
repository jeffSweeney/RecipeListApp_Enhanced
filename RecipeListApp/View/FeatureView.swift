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
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            // MARK: Title
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding()
                .font(.largeTitle)
            
            // MARK: Dish Card
            GeometryReader { geo in
                TabView {
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
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            // MARK: Prep Time and Highlights
            VStack (alignment: .leading, spacing: 10) {
                // TODO: Implement these details based on card being displayed above
                Text("Preparation Time:")
                    .font(.headline)
                Text("** IMPLEMENT **")
                Text("Highlights:")
                    .font(.headline)
                Text("** IMPLEMENT **")
            }
            .padding([.leading, .bottom])
        }
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
