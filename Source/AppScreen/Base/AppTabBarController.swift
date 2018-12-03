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
        }
        
        var viewControllers: [UIViewController] = []
        
        map: do {
            let controller = MapViewController()
            let navigationController = AppNavigationController(rootViewController: controller)
            let wireframe = MapWireframe(navigationController: navigationController)
            let presenter = MapPresenter(view: controller, interactor: MapInteractor(), wireframe: wireframe)
            controller.presenter = presenter
            viewControllers.append(controller)
        }
        
        chat: do {
            let controller = ChatViewController()
            let navigationController = AppNavigationController(rootViewController: controller)
            let wireframe = ChatWireframe(navigationController: navigationController)
            let presenter = ChatPresenter(view: controller, interactor: ChatInteractor(), wireframe: wireframe)
            controller.presenter = presenter
            viewControllers.append(controller)
        }
        
        profile: do {
            let controller = ProfileViewController()
            let navigationController = AppNavigationController(rootViewController: controller)
            let wireframe = ProfileWireframe(navigationController: navigationController)
            let presenter = ProfilePresenter(view: controller, interactor: ProfileInteractor(), wireframe: wireframe)
            controller.presenter = presenter
            viewControllers.append(controller)
        }
        
        self.setViewControllers(viewControllers, animated: false)
        self.selectedIndex = 0
    }
}
