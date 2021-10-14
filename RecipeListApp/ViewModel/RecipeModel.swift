//
//  RecipeModel.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/8/21.
//

import Foundation

class RecipeModel: ObservableObject {
    
    // Since this app only needs a single instance of the view model, this
    // functionality (with a private init()) makes it a singleton design.
    static let instance = RecipeModel()
    
    // Published data that will be presented to the app
    @Published var recipes = [Recipe]()
    
    private init() {
        // Assign the published property to the result of the recipe fetch/parse
        // in DataService
        recipes = DataService.fetchAndParseRecipeJSON()
    }
}
