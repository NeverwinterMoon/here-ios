//
//  RootWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/02.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppUIKit

public final class RootWireframe: RootWireframeInterface {

    public init(window: UIWindow) {
        self.window = window
    }
    
    public func setWelcome() {
        let controller = WelcomeViewController()
        let navigationController = AppNavigationController(rootViewController: controller)
        let wireframe = WelcomeWireframe(navigationController: navigationController)
        let presenter = WelcomePresenter(view: controller, wireframe: wireframe)
        controller.presenter = presenter
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
//        let controller = ProfileViewController()
//        let navigationController = AppNavigationController(rootViewController: controller)
//        let wireframe = ProfileWireframe(navigationController: navigationController)
//        let presenter = ProfilePresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
//        controller.presenter = presenter
//        viewControllers.append(navigationController)
//
//        navigationController.tabBarItem = UITabBarItem(
//            title: "profile",
//            image: UIImage(named: "first"),
//            selectedImage: UIImage(named: "first")
//        )
    }
    
    public func setRootTabBar() {
        let controller = AppTabBarController()
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Private
    private weak var window: UIWindow?
    private weak var rootViewController: UIViewController? {
        
        return self.window?.rootViewController
    }
}
