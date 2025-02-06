//
//  TabBarCoordinator.swift
//  Dodo
//
//  Created by Tia M on 12/8/24.
//

import UIKit

class TabBarCoordinator: BaseCoordinator {
    
    var finishFlow: ((Bool)->())?
    
    var tabBarController: UITabBarController
    
    private let router: Router
    private let screenFactory: ScreenFactory
    private let coordinatorFactory: CoordinatorFactory
    
    //Модульные координаторы - управляет экранами
    init(router: Router, screenFactory: ScreenFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.screenFactory = screenFactory
        self.coordinatorFactory = coordinatorFactory
        self.tabBarController = .init()
    }
    
    override func start() {
        
        let pages: [TabBarPage] = [.menu, .profile, .cart]
        let controllers: [UINavigationController] = pages.map({ createTabController($0) })
        setupTabBarController(withTabControllers: controllers)
    }
    
//    func showDetail(_ product: Product) {
//        let detailScreen = screenFactory.makeDetailScreen()
//        detailScreen.update(product)
//        router.present(detailScreen, animated: true)
//    }
    
//    func showStory(_ stories: [Story], _ indexPath: IndexPath) {
//        let storiesScreen = screenFactory.makeStoriesScreen()
//        router.present(storiesScreen, animated: true)
//        storiesScreen.update(stories, indexPath)
//    }
}

//MARK: Coordinator Flows

extension TabBarCoordinator {
    func runMapFlow() {
        
        let coordinator = coordinatorFactory.makeMapCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self, weak coordinator] in // ???
            self?.removeDependency(coordinator)
        }

        
        self.addDependency(coordinator)
        coordinator.start()
    }

}

extension TabBarCoordinator {
    
    private func setupTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.menu.makeOrder()
        router.setRootModule(tabBarController)
    }
    
    private func createTabController(_ page: TabBarPage) -> UINavigationController {
        
        let navController = UINavigationController()
        
        navController.setNavigationBarHidden(true, animated: false)
        
        navController.tabBarItem = UITabBarItem.init(title: page.makeTitle(),
                                                     image: page.makeIcon(),
                                                     tag: page.makeOrder())
        
        switch page {
        case .menu:
            let menuVC = screenFactory.makeMenuScreen()
            
            menuVC.onProductSelected = { [weak self, weak router] product in
                let detailScreen = self?.screenFactory.makeDetailScreen()
                detailScreen?.update(product)
                router?.present(detailScreen, animated: true)
//                self?.showDetail(product)
            }
            
            menuVC.onStorySelected = { [weak self, weak router] stories, indexPath in
                let storiesScreen = self?.screenFactory.makeStoriesScreen()
                router?.present(storiesScreen, animated: true)
                storiesScreen?.update(stories, indexPath)
//                self?.showStory(stories, indexPath)
            }
            
            menuVC.onAddressTapped = { [weak self] in
//                self.showAddressList()
                self?.runMapFlow()
            }
            
            navController.pushViewController(menuVC, animated: true)
            
        case .profile:
            let profileVC = screenFactory.makeProfileScreen()
            
            profileVC.onLogout = { [weak self] isLogout in
                self?.finishFlow?(isLogout)
            }
            navController.pushViewController(profileVC, animated: true)
            
        case .cart:
            let cartVC = screenFactory.makeCartScreen()
            navController.pushViewController(cartVC, animated: true)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? {
        TabBarPage.init(index: tabBarController.selectedIndex)
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.makeOrder()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.makeOrder()
    }
}
