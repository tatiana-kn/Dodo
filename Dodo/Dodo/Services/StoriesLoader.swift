//
//  StoriesLoader.swift
//  Dodo
//
//  Created by Tia M on 10/6/24.
//

import Foundation

protocol IStoriesLoader {
    func loadStories(handler: @escaping(Result<[Story], Error>) -> Void)
}

struct StoriesLoader: IStoriesLoader {
    
    private let networkClient: INetworkClient
    private let decoder: JSONDecoder
    
    private var StoriesURL: URL {
        guard let url = URL(string: "http://localhost:3001/stories") else {
            preconditionFailure("Unable to construct usersURL")
        }
        return url
    }
    
    init(networkClient: INetworkClient = NetworkClient(), decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    
    func loadStories(handler: @escaping (Result<[Story], any Error>) -> Void) {
        networkClient.fetch(url: StoriesURL) { result in
            switch result {
            case .success(let data):
                do {
                    let storiesResponse = try decoder.decode(StoriesResponse.self, from: data)
                    handler(.success(storiesResponse.stories))
                } catch {
                    handler(.failure(error))
                }
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
