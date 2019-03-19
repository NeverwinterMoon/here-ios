//
//  RootWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/02.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppUIKit
import AppInteractor

public final class RootWireframe: RootWireframeInterface {

    public let window = UIWindow(frame: UIScreen.main.bounds)
    public static let shared = RootWireframe()
    
    private init() {}
    
    public func setWelcome() {
        
        let controller = WelcomeViewController()
        let navigationController = AppNavigationController(rootViewController: controller)
        let wireframe = WelcomeWireframe(navigationController: navigationController)
        let presenter = WelcomePresenter(view: controller, interactor: WelcomeInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    public func setRootTabBar(loggedIn: Bool) {
        
        let controller = AppTabBarController()
        
        if loggedIn {
            
            UIView.transition(
                with: self.window,
                duration: 0.5,
                options: .transitionFlipFromLeft,
                animations: {
                    self.window.rootViewController = controller
                },
                completion: nil
            )
        } else {
            self.window.rootViewController = controller
            self.window.makeKeyAndVisible()
        }
    }
    
    // MARK: - Private
//    private weak var window: UIWindow?
    private weak var rootViewController: UIViewController? {
        return self.window.rootViewController
    }
}
