//
//  AppTabBarController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/29.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import AppInteractor
import AppUIKit

final class AppTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    convenience init() {
        
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.delegate = self
        
        self.tabBar.do {
            
            $0.tintColor = .blue
            $0.unselectedItemTintColor = .gray
        }
        
        var viewControllers: [UIViewController] = []
        
        map: do {
            let controller = MapViewController()
            let navigationController = AppNavigationController(rootViewController: controller)
            let wireframe = MapWireframe(navigationController: navigationController)
            let presenter = MapPresenter(view: controller, interactor: MapInteractor(), wireframe: wireframe)
            controller.presenter = presenter
            viewControllers.append(navigationController)
            
            navigationController.tabBarItem = UITabBarItem(
                title: "map",
                image: UIImage(named: "first"),
                selectedImage: UIImage(named: "first")
            )
        }
        
        chat: do {
            let controller = ChatRoomListViewController()
            let navigationController = AppNavigationController(rootViewController: controller)
            let wireframe = ChatRoomListWireframe(navigationController: navigationController)
            let presenter = ChatRoomListPresenter(view: controller, interactor: ChatInteractor.shared, wireframe: wireframe)
            controller.presenter = presenter
            viewControllers.append(navigationController)
            
            navigationController.tabBarItem = UITabBarItem(
                title: "chat",
                image: UIImage(named: "first"),
                selectedImage: UIImage(named: "first")
            )
        }
        
        profile: do {
            let controller = ProfileViewController()
            let navigationController = AppNavigationController(rootViewController: controller)
            let wireframe = ProfileWireframe(navigationController: navigationController)
            let presenter = ProfilePresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
            controller.presenter = presenter
            viewControllers.append(navigationController)
            
            navigationController.tabBarItem = UITabBarItem(
                title: "profile",
                image: UIImage(named: "first"),
                selectedImage: UIImage(named: "first")
            )
        }

        self.setViewControllers(viewControllers, animated: false)
        self.selectedIndex = 2
    }
}
