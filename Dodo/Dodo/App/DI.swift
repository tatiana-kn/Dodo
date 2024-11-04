//
//  DI.swift
//  Dodo
//
//  Created by Tia M on 11/4/24.
//

import Foundation

final class DI {
    let networkClient: NetworkClient
    let decoder: JSONDecoder
    let productsLoader: ProductsLoader
    let ingredientsLoader: IngredientsLoader
    let storiesLoader: StoriesLoader
    let productsRepository: ProductsRepository
    let addressRepository: ProductsRepository
    let locationService: LocationService
    let geocodeService: GeocodeService
    
    let screenFactory: ScreenFactoryImpl
    
    init() {
        networkClient = NetworkClient()
        decoder = JSONDecoder()
        productsLoader = ProductsLoader(networkClient: networkClient, decoder: decoder)
        ingredientsLoader = IngredientsLoader(networkClient: networkClient, decoder: decoder)
        storiesLoader = StoriesLoader(networkClient: networkClient, decoder: decoder)
        productsRepository = ProductsRepository()
        addressRepository = ProductsRepository()
        locationService = LocationService()
        geocodeService = GeocodeService()
        
        screenFactory = ScreenFactoryImpl()
        screenFactory.di = self
    }
}

protocol ScreenFactory {
    func makeMenuScreen() -> MenuScreenVC
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var di: DI!
    
    
    func makeMenuScreen() -> MenuScreenVC {
        //MenuConfigurator().configure(di)
        return MenuScreenVC(di.productsLoader)
        //viewController.productLoader = di.productsLoader
        //return viewController
    }
    
    func makeDetailScreen() -> DetailScreenVC {
        return DetailScreenVC(di.ingredientsLoader)
    }
    
}

