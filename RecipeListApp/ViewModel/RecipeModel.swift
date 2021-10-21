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
    
    // This function will handle all business logic for portion calculation, name normalization, etc.
    static func getPortion(ingredient i: Ingredient, recipeServings rS: Int, targetServings tS: Int) -> String {
        var result = ""
        // If portion is > 1, we'll need an 's' suffix for the unit to make it plural
        var needSuffix = false
        
        // MARK: Portion Calculation
        // If there's no num, then there's no portion for this ingredient
        // i.e. "Salt to taste"
        if let numerator = i.num {
            // Single serving = denom * recipe.servings
            let denomenator = i.denom ?? 1
            let singleServingDenom = denomenator * rS
            
            // Target portion = num * target servings
            let targetPortionNum = numerator * tS
            
            // Convert to double
            let doubleResult = Double(targetPortionNum) / Double(singleServingDenom)
            
            // Get fraction reprsentation
            let fraction = RationalUtil.rationalApproximation(of: doubleResult)
            
            // Store the result as a string
            if fraction.num > fraction.den {
                // Now established we're working with plural unit
                needSuffix = true
                
                let wholePortion = fraction.num/fraction.den
                var separator = ""
                var rest = ""
                
                let remainder = fraction.num % fraction.den
                if remainder > 0 {
                    separator = " "
                    rest = "\(remainder)/\(fraction.den)"
                }
                
                result = "\(wholePortion)\(separator)\(rest)"
            } else if fraction.num == fraction.den {
              // This could've been grouped above, but all that calculation is redundant
              // when we could just call it 1 here. Also, suffix simpler to work with now.
                result = "1"
            } else {
                result = "\(fraction.num)/\(fraction.den)"
            }
        }
        
        // MARK: Unit Calculation
        // Add unit with appropriate spacing if needed
        if let unit = i.unit {
            let spacing = result == "" ? "" : " "
            var normalizedUnit = unit
            
            // Determine if suffix is needed and appropriate suffix type.
            if needSuffix {
                // Examples:
                // Cup   -> Cups
                // Bunch -> Bunches
                // Leaf  -> Leaves
                if unit.suffix(2) == "ch" {
                    normalizedUnit += "es"
                } else if unit.suffix(1) == "f" {
                    normalizedUnit = "\(unit.dropLast())ves"
                } else {
                    normalizedUnit += "s"
                }
                
                
            }
            
            result += "\(spacing)\(normalizedUnit)"
        }

        return result
    }
}
