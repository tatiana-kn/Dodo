//
//  Coordinator.swift
//  Dodo
//
//  Created by Tia M on 12/8/24.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
}

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    func start() {}
    
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeDependency($0) })
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}




//class MenuCoordinator: BaseCoordinator {
//    
//    private let router: Router
//    private let screenFactory: ScreenFactory
//    
//    //Модульные координаторы - управляет экранами
//    init(router: Router, screenFactory: ScreenFactory) {
//        self.router = router
//        self.screenFactory = screenFactory
//    }
//    
//    
//    override func start() {
//        
//        let menuScreen = screenFactory.makeMenuScreen()
//        
//        menuScreen.onProductSelected = { product in
//            
//            self.showDetail(product)
//            print("onProductSelected")
//        }
//        
//        menuScreen.onStorySelected = { stories, indexPath in
//            self.showStory(stories, indexPath)
//        }
//        print("start")
//        router.setRootModule(menuScreen, hideBar: true)
//    }
//    
//    func showDetail(_ product: Product) {
//        
//        let detailScreen = screenFactory.makeDetailScreen()
//        print("showDetail")
//
//        detailScreen.update(product) // ??
//        
//        router.present(detailScreen, animated: true)
//    }
//    
//    func showStory(_ stories: [Story], _ indexPath: IndexPath) {
//        
//        let storiesScreen = screenFactory.makeStoriesScreen()
//    
//        router.present(storiesScreen, animated: true)
//        
//        storiesScreen.update(stories, indexPath)
//    }
//}

