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
    let addressRepository: AddressRepository
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
        addressRepository = AddressRepository()
        locationService = LocationService()
        geocodeService = GeocodeService()
        
        screenFactory = ScreenFactoryImpl()
        screenFactory.di = self
    }
}

protocol ScreenFactory {
    func makeMenuScreen() -> MenuScreenVC
    func makeStoriesScreen() -> StoriesScreenVC
    func makeDetailScreen() -> DetailScreenVC
    func makeCartScreen() -> CartScreenVC
    func makeAddressListScreen() -> AddressListScreenVC
    func makeMapScreen() -> MapScreenVC
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var di: DI!
    
    
    func makeMenuScreen() -> MenuScreenVC {
        //MenuConfigurator().configure(di)
        return MenuScreenVC(productsLoader: di.productsLoader, storiesLoader: di.storiesLoader, addressRepository: di.addressRepository)
        //viewController.productLoader = di.productsLoader
        //return viewController
    }
    
    func makeDetailScreen() -> DetailScreenVC {
        return DetailScreenVC(ingredientsLoader: di.ingredientsLoader, productsRepository: di.productsRepository)
    }
    
    func makeCartScreen() -> CartScreenVC {
        return CartScreenVC(productsRepository: di.productsRepository)
    }
    
    func makeStoriesScreen() -> StoriesScreenVC {
        return StoriesScreenVC() // ??
    }
    
    func makeAddressListScreen() -> AddressListScreenVC {
        return AddressListScreenVC(addressRepository: di.addressRepository)
    }
    
    func makeMapScreen() -> MapScreenVC {
        return MapScreenVC(addressRepository: di.addressRepository, locationService: di.locationService, geocodeService: di.geocodeService)
    }
}

