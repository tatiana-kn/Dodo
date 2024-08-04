//
//  Product.swift
//  Dodo
//
//  Created by Tia M on 6/29/24.
//

import Foundation

struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let name: String
    let detail: String
    let price: Int
    let image: String
    let ingredients: [Ingredient]?
}

struct IngredientsResponse: Decodable {
    let ingredients: [Ingredient]
}

struct Ingredient: Decodable {
    let name: String
    let image: String
    let price: Int
}
