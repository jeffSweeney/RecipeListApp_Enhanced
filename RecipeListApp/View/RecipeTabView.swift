//
//  RecipeTabView.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/16/21.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        TabView {
            Text("Featured View")
                .tabItem {
                    // TODO: Implement featured page
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
            
            RecipeListAppView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("All Recipes")
                }
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
