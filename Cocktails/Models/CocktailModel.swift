//
//  CocktailModel.swift
//  Cocktails
//
//  Created by Кирилл Бахаровский on 10/19/24.
//

import Foundation

struct Cocktail: Codable {
    
    let name: String?
    let instructions: String
    
    let ingredients: [String]?
}
