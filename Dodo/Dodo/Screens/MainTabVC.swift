//
//  MainTabVC.swift
//  Dodo
//
//  Created by Tia M on 8/15/24.
//

import UIKit

class MainTabVC: UITabBarController {
    
    let menuController: MenuScreenVC = {
        let controller = di.screenFactory.makeMenuScreen()
        let tabItem = UITabBarItem.init(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        controller.tabBarItem = tabItem
        return controller
    }()

    let profileController: UIViewController = {
        let controller = UIViewController()
        let tabItem = UITabBarItem.init(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        controller.tabBarItem = tabItem
        return controller
    }()
    
    let cartController: CartScreenVC = {
        let controller = CartScreenVC()
        let tabItem = UITabBarItem.init(title: "", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart"))
        controller.tabBarItem = tabItem
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .lightGray
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.darkGray
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        viewControllers = [menuController,cartController, profileController]
 
    }
}

#Preview(traits: .portrait) {
    MainTabVC()
}
