//
//  ProductsService.swift
//  Dodo
//
//  Created by Tia M on 6/29/24.
//

import Foundation

class ProductsService {
    
    private var ingredients: [Ingredient] = [
        Ingredient(name: "томаты", image: "tomato", price: 30),
        Ingredient(name: "ананасы", image: "pineapple", price: 50),
        Ingredient(name: "лук", image: "onion", price: 100)
    ]
    
    private lazy var products: [Product] = [
        Product(name: "Гавайская",
                detail: "Фирменный соус альфредо, цыпленок, моцарелла, ананасы",
                price: 639,
                image: "hawaii",
                ingredients: ingredients),
        Product(name: "Маргарита",
                detail: "Увеличенная порция моцареллы, томаты, итальянские травы, фирменный томатный соус",
                price: 569,
                image: "margarita",
                ingredients: ingredients),
        Product(name: "Пепперони",
                detail: "Пикантная пепперони, увеличенная порция моцареллы, фирменный томатный соус",
                price: 639,
                image: "pepperoni",
                ingredients: ingredients),
        Product(name: "Сырная",
                detail: "Моцарелла, сыры чеддер и пармезан, фирменный соус альфредо",
                price: 499,
                image: "cheez",
                ingredients: ingredients),
        Product(name: "Аррива!",
                detail: "Острая чоризо, цыпленок, томаты, соус бургер, сладкий перец, красный лук, моцарелла, соус ранч, чеснок",
                price: 639,
                image: "arriva",
                ingredients: ingredients),
        Product(name: "Додо",
                detail: "Бекон, митболы, пикантная пепперони, моцарелла, томаты, шампиньоны, сладкий перец, красный лук, чеснок, фирменный томатный соус",
                price: 819,
                image: "dodo",
                ingredients: ingredients),
        Product(name: "Диабло",
                detail: "Острая чоризо, острый перец халапенью, соус барбекю, митболы, томаты, сладкий перец, красный лук, моцарелла, фирменный томатный соус",
                price: 819,
                image: "diablo",
                ingredients: ingredients),
        Product(name: "Бургер-пицца",
                detail: "Ветчина, маринованные огурчики, томаты, красный лук, чеснок, соус бургер, моцарелла, фирменный томатный соус",
                price: 639,
                image: "burger-pizza",
                ingredients: ingredients),
        
    ]
    
    func fetchProduct() -> [Product] {
        products
    }
}
