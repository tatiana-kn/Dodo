//
//  LoginCoordinator.swift
//  Dodo
//
//  Created by Tia M on 12/16/24.
//

import Foundation

class LoginCoordinator: BaseCoordinator {
    
    var finishFlow: ((Bool)->())?
    
    private let router: Router
    private let screenFactory: ScreenFactory
    
    //Модульные координаторы - управляет экранами
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    
    override func start() {
        
        let loginScreen = screenFactory.makeLoginScreen()
        
        loginScreen.onUserLogged = { isLogged in
            
            self.finishFlow?(isLogged)
        }
        
        router.setRootModule(loginScreen, hideBar: false)
    }
}
