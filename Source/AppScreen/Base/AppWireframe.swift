//
//  AppWireframe.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit
import AppUIKit
import AppExtensions

enum Transition {
    case push
    case present
}

class AppWireframe: WireframeInterface {
    
    unowned let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func popFromNavigationController(animated: Bool) {
        _ = self.navigationController.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.navigationController.dismiss(animated: animated, completion: completion)
    }
    
    func show(_ viewController: UIViewController, with transition: Transition, animated: Bool) {
        
        switch transition {
        case .push:
            self.navigationController.pushViewController(viewController, animated: animated)
        case .present:
            self.navigationController.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func navigationControllerOnSwitch(tabIndex: ViewType) -> UINavigationController? {
        
        guard let window = UIApplication.shared.delegate?.window, let tabBarController = window?.rootViewController as? UITabBarController else {
            return nil
        }
        
        let index: Int
        switch tabIndex {
        case .map: index = 0
        case .profile: index = 1
        }
        
        tabBarController.selectedIndex = index
        return tabBarController.viewControllers?[index] as? UINavigationController
    }
    
    enum ViewType {
        case map
        case profile
    }
}
