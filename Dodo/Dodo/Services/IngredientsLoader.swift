//
//  IngredientsLoader.swift
//  Dodo
//
//  Created by Tia M on 8/3/24.
//

import Foundation

protocol IIngredientsLoader {
    func loadIngredients(handler: @escaping(Result<[Ingredient], Error>) -> Void)
}

struct IngredientsLoader: IIngredientsLoader {
    
    private let networkClient: INetworkClient
    private let decoder: JSONDecoder
    
    private var ingredientURL: URL {
        guard let url = URL(string: "http://localhost:3001/ingredients") else {
            preconditionFailure("Unable to construct usersURL")
        }
        return url
    }
    
    init(networkClient: INetworkClient = NetworkClient(), decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    
    func loadIngredients(handler: @escaping (Result<[Ingredient], any Error>) -> Void) {
        networkClient.fetch(url: ingredientURL) { result in
            switch result {
            case .success(let data):
                do {
                    let ingredientsResponse = try decoder.decode(IngredientsResponse.self, from: data)
                    handler(.success(ingredientsResponse.ingredients))
                } catch {
                    handler(.failure(error))
                }
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
