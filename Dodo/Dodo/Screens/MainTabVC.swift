//
//  MainTabVC.swift
//  Dodo
//
//  Created by Tia M on 8/15/24.
//

import UIKit

enum TabBarPage {
    case menu
    case cart
    case profile

    init?(index: Int) {
        switch index {
        case 0:
            self = .menu
        case 1:
            self = .cart
        case 2:
            self = .profile
        default:
            return nil
        }
    }
    
    func makeTitle() -> String {
        switch self {
        case .menu:
            return "Меню"
        case .cart:
            return "Корзина"
        case .profile:
            return "Профиль"
        }
    }

    func makeOrder() -> Int {
        switch self {
        case .menu:
            return 0
        case .cart:
            return 1
        case .profile:
            return 2
        }
    }
    
        func makeIcon() -> UIImage? {
        switch self {
        case .menu:
            return UIImage(systemName:  "menucard")
        case .cart:
            return UIImage(systemName: "cart")
        case .profile:
            return UIImage(systemName: "person")
        }
    }

        func makeIconSelected() -> UIImage? {
        switch self {
        case .menu:
            return  UIImage(systemName:  "menucardSelected")
        case .cart:
            return  UIImage(systemName: "cartSelected")
        case .profile:
            return  UIImage(systemName: "personSelected")
        }
    }
}

//class MainTabVC: UITabBarController {
    
//    let menuVC: MenuScreenVC = {
//        return di.screenFactory.makeMenuScreen()
//    }()
//
//    let profileVC: ProfileScreenVC = {
//        return di.screenFactory.makeProfileScreen()
//    }()
//    
//    let cartVC: CartScreenVC = {
//        return di.screenFactory.makeCartScreen()
//    }()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
    
//    private func setup() {
//        tabBar.tintColor = .lightGray
//        viewControllers = [menuVC, cartVC, profileVC]
//        
//        for (index, controller) in [menuVC, cartVC, profileVC].enumerated() {
//            let page = TabBarPage.init(index: index)
//            let tabItem = UITabBarItem.init(title: page?.makeTitle(), image: page?.makeIcon(), selectedImage: page?.makeIconSelected())
//            controller.tabBarItem = tabItem
//        }
//    }
//}

//class MainTabVC: UITabBarController {
//    
//    let menuController: MenuScreenVC = {
//        let controller = di.screenFactory.makeMenuScreen()
//        let tabItem = UITabBarItem.init(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
//        controller.tabBarItem = tabItem
//        return controller
//    }()
//
//    let profileController: ProfileScreenVC = {
//        let controller = di.screenFactory.makeProfileScreen()
//        let tabItem = UITabBarItem.init(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
//        controller.tabBarItem = tabItem
//        return controller
//    }()
//    
//    let cartController: CartScreenVC = {
//        let controller = di.screenFactory.makeCartScreen()
//        let tabItem = UITabBarItem.init(title: "", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart"))
//        controller.tabBarItem = tabItem
//        return controller
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .lightGray
//        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.darkGray
//        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
//        
//        tabBar.standardAppearance = appearance
//        tabBar.scrollEdgeAppearance = appearance
//        viewControllers = [menuController,cartController, profileController]
// 
//    }
//}

//#Preview(traits: .portrait) {
//    MainTabVC()
//}
