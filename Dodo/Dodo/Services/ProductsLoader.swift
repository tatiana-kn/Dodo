//
//  ProductsLoader.swift
//  Dodo
//
//  Created by Tia M on 7/26/24.
//

import Foundation

protocol IProductsLoader {
    func loadProducts(handler: @escaping(Result<[Product], Error>) -> Void)
}

struct ProductsLoader: IProductsLoader {
    private let networkClient: INetworkClient
    private let decoder: JSONDecoder
    
    init(networkClient: INetworkClient = NetworkClient(), decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }

// MARK: - URL
    private var productsURL: URL {
        guard let url = URL(string: "http://localhost:3001/products") else {
            preconditionFailure("Unable to construct usersURL")
        }
        return url
    }
    
    func loadProducts(handler: @escaping (Result<[Product], Error>) -> Void) {
        networkClient.fetch(url: productsURL) { result in
            switch result {
            case .success(let data):
                do {
                    let productsResponse = try decoder.decode(ProductResponse.self, from: data)
                    handler(.success(productsResponse.products))
                } catch {
                    handler(.failure(error))
                }
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
