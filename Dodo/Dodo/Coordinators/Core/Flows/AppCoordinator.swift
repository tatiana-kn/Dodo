//
//  AppCoordinator.swift
//  Dodo
//
//  Created by Tia M on 12/16/24.
//

import Foundation

class AppCoordinator: BaseCoordinator {
    
    private let router: Router //Держит корневой контроллер
    private let coordinatorFactory: CoordinatorFactory
    
    //Корневой кооридантор - должен иметь ссылку фабрику координаторов
    //Корневой координатор - управляет координаторами
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
//        runStartFlow()
        runLoginFlow()
    }
    
    func runLoginFlow() {
        
        let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
        
        coordinator.finishFlow = { isLogged in
            
            self.runMainFlow()
            
            self.removeDependency(coordinator)
        }
        
        self.addDependency(coordinator)
        
        coordinator.start()
    }
    
    func runMainFlow() {
        
        let coordinator = coordinatorFactory.makeTabBarCoordinator(router: router)
        
        coordinator.finishFlow = { isLogouted in
            
            self.runLoginFlow()
            
            self.removeDependency(coordinator)
        }
        
        self.addDependency(coordinator)
        coordinator.start()
    }
    
//    func runMapFlow() { // ???
//        
//        let coordinator = coordinatorFactory.makeMapCoordinator(router: router)
//        
//        
//        coordinator.onAddressSaved = {
//            
//            self.removeDependency(coordinator)
//        }
//
//        
//        self.addDependency(coordinator)
//        coordinator.start()
//    }
}
