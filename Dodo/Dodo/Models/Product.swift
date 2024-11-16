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
    let type: String
    let detail: String
    let price: Int
    let image: String
    
//    var ingredients: [Ingredient]?
    var ingredients: Set<Ingredient>?
    var count: Int?
    var doughType: DoughType?
    var size: Size?
    var calculatedPrice: Int?

}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.name == rhs.name &&
        lhs.doughType == rhs.doughType &&
        lhs.size == rhs.size 
//        lhs.ingredients == rhs.ingredients
    }
}

extension Product {
    mutating func calculatePrice() {
        let basePrice = Double(price) * Size.getPriceMultiplier(for: size ?? .medium)
        let ingredientsPrice = (ingredients?.compactMap { $0.price }.reduce(0, +)) ?? 0
        self.calculatedPrice = Int(basePrice) + ingredientsPrice
    }
}

enum DoughType: String, Codable {
    case thin = "Тонкое"
    case traditional = "Традиционное"
    
    static func getDoughType(_ index: Int) -> DoughType {
        return index == 0 ? DoughType.traditional : DoughType.thin
    }
}

enum Size: String, Codable {
    case small = "Маленькая"
    case medium = "Средняя"
    case large = "Большая"
    
    static func getSize(_ index: Int) -> Size {
        if index == 0 {
            return Size.small
        } else if index == 2 {
            return Size.large
        } else {
            return Size.medium
        }
    }
    
    static func getPriceMultiplier(for size: Size) -> Double {
        switch size {
        case .small:
            return 0.85
        case .medium:
            return 1
        case .large:
            return 1.15
        }
    }
}

struct IngredientsResponse: Codable {
    let ingredients: [Ingredient]
}

struct Ingredient: Codable, Hashable {
    let name: String
    let image: String
    let price: Int
}

extension Ingredient: Equatable {
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.name == rhs.name
    }
}

struct StoriesResponse: Codable {
    let stories: [Story]
}

struct Story: Codable {
    let path: String
}

