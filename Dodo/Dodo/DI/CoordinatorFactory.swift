//
//  CoordinatorFactory.swift
//  Dodo
//
//  Created by Tia M on 12/8/24.
//

import Foundation

protocol CoordinatorFactory {
    func makeApplicationCoordinator(router: Router) -> AppCoordinator
    func makeLoginCoordinator(router: Router) -> LoginCoordinator
    func makeTabBarCoordinator(router: Router) -> TabBarCoordinator
    
    func makeMapCoordinator(router: Router) -> MapCoordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    private let screenFactory: ScreenFactory
    
    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> AppCoordinator {
        return AppCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeLoginCoordinator(router: Router) -> LoginCoordinator {
        return LoginCoordinator(router: router,screenFactory: screenFactory)
    }
    
    func makeTabBarCoordinator(router: Router) -> TabBarCoordinator {
        return TabBarCoordinator(router: router, screenFactory: screenFactory, coordinatorFactory: self)
    }
    
    func makeMapCoordinator(router: Router) -> MapCoordinator {
        return MapCoordinator(router: router, screenFactory: screenFactory)
    }
}
