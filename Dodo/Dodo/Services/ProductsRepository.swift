//
//  ProductRepository.swift
//  Dodo
//
//  Created by Tia M on 8/23/24.
//

import Foundation

//Класс-сервис - бизнес-логика - архивируем массив продуктов

protocol IProductsRepository {
    func retrieve() -> [Product] //закдалываем их массивом
    func add(_ product: Product)
    func update(_ product: Product)
}

final class ProductsRepository: IProductsRepository {
    
    private let encoder = JSONEncoder() //кодирует в бинарник
    private let decoder = JSONDecoder() //разкодирует
    
    private let key = "Products"
    
    //MARK: - Public methods
    private func save(_ products: [Product]) { //метод сохранить
        
        //Array<Product> -> Data
        //массив кладем в бинарник и кодируем, бинарник кладем в UserDefaults
        do {
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    //retrieve - получить данные
    func retrieve() -> [Product] {  //метод получить
        
        //Data -> Array<Product>
        //вытаскиваем из UserDefaults бинарник
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            //раскодировали бинарник в массив
            let array = try decoder.decode(Array<Product>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
    func add(_ product: Product) {
        var array = retrieve()
        
        if let index = array.firstIndex(where: { $0.name == product.name }) {
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
    
    func delete(_ product: Product) { //  удалить?
        var array = retrieve()
        
        if let index = array.firstIndex(where: { $0.name == product.name }) {
            if let count = array[index].count {
                array[index].count = count - 1
            }
        }
        
        array.removeAll { $0.count == 0 }
//        array.append(product)
        save(array)
        print(array)
    }
    
    func update(_ product: Product) {
        var array = retrieve()
        
        if let index = array.firstIndex(where: { $0.name == product.name }) {
            if let count = array[index].count {
                array[index].count = product.count
            }
        }
        array.removeAll { $0.count == 0 }
        save(array)
        print(array)
    }
}
