//
//  RecipeHighlightsView.swift
//  RecipeListApp
//
//  Created by Jeffrey Sweeney on 10/21/21.
//

import SwiftUI

struct RecipeHighlightsView: View {
    
    var highlights: String
    
    init(highlightsArray: [String]) {
        highlights = highlightsArray.map{$0}.joined(separator: ", ")
    }
    
    var body: some View {
        Text(highlights)
            .font(Font.custom("Avenir", size: 16))
    }
}

struct RecipeHighlightsView_Previews: PreviewProvider {
    static var previews: some View {
        // Dummy data for testing in the canvas
        let highlights = ["Fast", "Easy to make", "Beginner friendly"]
        RecipeHighlightsView(highlightsArray: highlights)
    }
}
