//
//  MapCoordinator.swift
//  Dodo
//
//  Created by Tia M on 12/16/24.
//

import Foundation
import UIKit

class MapCoordinator: BaseCoordinator {
    
    private let router: Router
    private let screenFactory: ScreenFactory
    
    var finishFlow: (() -> Void)?
    
    //Модульные координаторы - управляет экранами
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    
    override func start() {
        
        let addressListScreen = screenFactory.makeAddressListScreen()
        
        //        addressListScreen.onNewAddressButtonTapped = {
        //            self.showMapScreen()
        //        }
        //
        //        addressListScreen.onEditButtonTapped = { address in
        //            self.showEditMapScreen(with: address)
        //        }
        //
        //        addressListScreen.onDeliverToAddressButtonTapped = {
        //            self.finishFlow?()
        //        }
        configureAddressListScreen(addressListScreen)
        
        router.present(addressListScreen, animated: true, onRoot: true)
    }
    
    func configureAddressListScreen(_ screen: AddressListScreenVC) {
        screen.onNewAddressButtonTapped = { [weak self] in
            guard let self = self else { return }
            let mapScreen = self.showMapScreen()
            
            mapScreen.onAddressSaved = { [weak screen] in
                screen?.loadAddressListFromRepository()
            }
        }
        
        screen.onEditButtonTapped = { [weak self] address in
//            let mapScreen = self.screenFactory.makeMapScreen()
            guard let self = self else { return }
            let mapScreen = self.showMapScreen()
            mapScreen.address = address
//            self.router.present(mapScreen, animated: true, onRoot: false)
            
            mapScreen.onAddressSaved = { [weak screen] in
                screen?.loadAddressListFromRepository()
            }
        }
        
        screen.onDeliverToAddressButtonTapped = { [weak self] in
            
            guard let navigationVC = screen.presentingViewController as? UINavigationController else { return }
            
            guard let tabVC = navigationVC.viewControllers.first as? UITabBarController else { return }
            
            for navVC in tabVC.viewControllers?.compactMap({ $0 as? UINavigationController }) ?? [] {
                for controller in navVC.viewControllers {
                    
                    if let menuVC  = controller as? MenuScreenVC {
                        
                        menuVC.loadAddressFromRepository()
                    }
                }
            }
            self?.finishFlow?()
        }
    }
    
    func showMapScreen() -> MapScreenVC {
        let mapScreen = self.screenFactory.makeMapScreen()
        
        let navigationController = UINavigationController(rootViewController: mapScreen)
        self.router.present(navigationController, animated: true, onRoot: false)
        return mapScreen
    }
}
//    func showMapScreen() {
//        let mapScreen = screenFactory.makeMapScreen()
//                
//        router.present(mapScreen, animated: true, onRoot: false)
//    }
//    
//    func showEditMapScreen(with address: Address) {
//        let mapScreen = screenFactory.makeMapScreen()
//        
//        mapScreen.address = address
//        
//        router.present(mapScreen, animated: true, onRoot: false)
//    }
