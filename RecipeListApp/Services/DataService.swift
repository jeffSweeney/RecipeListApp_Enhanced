//
//  FetchAndParse.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/9/21.
//

import Foundation

class DataService {
    static func fetchAndParseRecipeJSON() -> [Recipe] {
        // Initialize empty to return this way in the event of any failures
        var resultArr = [Recipe]()
        
        // Create a path to the file in the Bundle
        if let stringPath = Bundle.main.path(forResource: "recipes", ofType: "json") {
            // Generate the URL from the path string
            let url = URL(fileURLWithPath: stringPath)
            
            // Build the Data object - can throw
            do {
                let data = try Data(contentsOf: url)
                
                // Decode the data - can throw
                let decoder = JSONDecoder()
                do {
                    let decodedArr = try decoder.decode([Recipe].self, from: data)
                    
                    // Add a UUID to each parsed recipe
                    for recipe in decodedArr {
                        recipe.id = UUID()
                        
                        // Also need to tag each ingredient in recipe with a UUID
                        for ingredient in recipe.ingredients {
                            ingredient.id = UUID()
                        }
                    }
                    
                    // Assign the parsed json to the result for return
                    resultArr = decodedArr
                } catch {
                    // Could not decode the JSON to Recipe
                    print(error)
                }
            } catch {
                // Could not construct the data object
                print(error)
            }
        }
        
        return resultArr
    }
}
