//
//  DependencyContainer.swift
//  Dodo
//
//  Created by Tia M on 12/8/24.
//

import Foundation
import UIKit

final class DependencyContainer {
    
    fileprivate let coordinatorFactory: CoordinatorFactoryImpl
    fileprivate let screenFactory: ScreenFactoryImpl
    
    let networkClient: NetworkClient
    let decoder: JSONDecoder
    let productsLoader: ProductsLoader
    let ingredientsLoader: IngredientsLoader
    let storiesLoader: StoriesLoader
    let productsRepository: ProductsRepository
    let addressRepository: AddressRepository
    let locationService: LocationService
    let geocodeService: GeocodeService
    
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
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
        
        screenFactory.di = self
    }
}

protocol AppFactory {
    func makeKeyWindowWithAppCoordinator(_ window: UIWindow?) -> (UIWindow?, Coordinator)
}

extension DependencyContainer: AppFactory {

    func makeKeyWindowWithAppCoordinator(_ window: UIWindow?) -> (UIWindow?, Coordinator) {
        let rootVC = UINavigationController()
        rootVC.setNavigationBarHidden(true, animated: false)
        
        let router = RouterImpl(rootController: rootVC)
        
        let coordinator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window?.rootViewController = rootVC
        return (window, coordinator)
    }
}
