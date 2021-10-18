//
//  RecipeTabView.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/16/21.
//

import SwiftUI

struct RecipeTabView: View {
    // This is highest common view with subviews that need the RecipeModel View
    // Model. We'll implement it here and share it as an environment object.
    private var recipeMode = RecipeModel.instance
    
    var body: some View {
        TabView {
            FeatureView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
            
            RecipeListAppView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("All Recipes")
                }
        }.environmentObject(recipeMode)
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
