//
//  ProductRepository.swift
//  Dodo
//
//  Created by Tia M on 8/23/24.
//

import Foundation

protocol IProductsRepository {
    func retrieve() -> [Product] 
    func add(_ product: Product)
    func update(_ product: Product, with  ingredients: [Ingredient])
    func update(_ product: Product)
}

final class ProductsRepository: IProductsRepository {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "Products"
    
    //MARK: - Public methods
    private func save(_ products: [Product]) {
        do {
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func retrieve() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode(Array<Product>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
    func add(_ product: Product) {
        var array = retrieve()
        
        if let index = array.firstIndex(where: { $0 == product && $0.ingredients == product.ingredients }) {
            if let count = array[index].count {
                array[index].count = count + 1
            }
        } else {
            var newProduct = product
            newProduct.count = 1
            array.append(newProduct)
        }
        
//        array.append(product)
        save(array)
        print(array)
    }
    
    func update(_ product: Product, with ingredients: [Ingredient]) {
        var array = retrieve()
        
        if let index = array.firstIndex(where: { $0 == product && $0.ingredients == product.ingredients }) {
            var productWithIngredients = product
            
            if productWithIngredients.ingredients == nil {
                productWithIngredients.ingredients = []
            }
//            productWithIngredients.ingredients?.append(contentsOf: ingredients)
            productWithIngredients.ingredients?.formUnion(ingredients)
            productWithIngredients.calculatePrice()
            array[index] = productWithIngredients
            if let count = array[index].count {
                array[index].count = count + 1
            }
        } else {
            var newProduct = product
            newProduct.ingredients = Set(ingredients)
            newProduct.count = 1
            newProduct.calculatePrice()
            array.append(newProduct)
        }
        save(array)
        print(array)
    }
    
    func update(_ product: Product) {
        var array = retrieve()
        
        if let index = array.firstIndex(where: { $0 == product && $0.ingredients == product.ingredients }) {
//            array[index].count = product.count
            var updatedProduct = array[index]
            updatedProduct.count = product.count
            updatedProduct.calculatePrice()
            array[index] = updatedProduct
        }
        array.removeAll { $0.count == 0 }
        save(array)
        print(array)
    }
}

//func delete(_ product: Product) { //  удалить?
//        var array = retrieve()
//
//        if let index = array.firstIndex(where: { $0.name == product.name }) {
//            if let count = array[index].count {
//                array[index].count = count - 1
//            }
//        }
//
//        array.removeAll { $0.count == 0 }
////        array.append(product)
//        save(array)
//        print(array)
//    }
