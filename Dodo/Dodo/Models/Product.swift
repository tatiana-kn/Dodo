//
//  Product.swift
//  Dodo
//
//  Created by Tia M on 6/29/24.
//

import Foundation

struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Codable {
    
    let name: String
    let detail: String
    let price: Int
    let image: String
    let ingredients: [Ingredient]?
    var count: Int?
}

struct IngredientsResponse: Codable {
    let ingredients: [Ingredient]
}

struct Ingredient: Codable {
    let name: String
    let image: String
    let price: Int
}

struct StoriesResponse: Codable {
    let stories: [Story]
}

struct Story: Codable {
    let path: String
}
