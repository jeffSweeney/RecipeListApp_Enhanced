//
//  Ingredient.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/18/21.
//

import Foundation

class Ingredient: Identifiable, Decodable {
    var id: UUID?
    var name: String
    var num: Int?
    var denom: Int?
    var unit: String?
}
