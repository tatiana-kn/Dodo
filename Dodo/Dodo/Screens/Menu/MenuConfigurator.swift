//
//  MenuConfigurator.swift
//  Dodo
//
//  Created by Tia M on 8/2/24.
//

import Foundation

final class MenuConfigurator {
    func configure() -> MenuScreenVC {
        let decoder = JSONDecoder()
        let networkClient = NetworkClient()
        let viewController = MenuScreenVC()
        
        viewController.productLoader = ProductsLoader(networkClient: networkClient, decoder: decoder)

        return viewController
    }
}

