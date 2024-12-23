//
//  ScreenFactory.swift
//  Dodo
//
//  Created by Tia M on 12/8/24.
//

import Foundation

protocol ScreenFactory {
    func makeLoginScreen() -> LoginScreenVC
    func makeMenuScreen() -> MenuScreenVC
    func makeStoriesScreen() -> StoriesScreenVC
    func makeDetailScreen() -> DetailScreenVC
    func makeCartScreen() -> CartScreenVC
    func makeAddressListScreen() -> AddressListScreenVC
    func makeMapScreen() -> MapScreenVC
    func makeProfileScreen() -> ProfileScreenVC
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var di: DependencyContainer!

    init(){}
    
    func makeLoginScreen() -> LoginScreenVC {
        return LoginScreenVC()
    }
    
    func makeMenuScreen() -> MenuScreenVC {

        return MenuScreenVC(productsLoader: di.productsLoader, storiesLoader: di.storiesLoader, addressRepository: di.addressRepository)

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
    
    func makeProfileScreen() -> ProfileScreenVC {
        return ProfileScreenVC()
    }
}
