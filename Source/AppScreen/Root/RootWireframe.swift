//
//  RootWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/02.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

public final class RootWireframe: RootWireframeInterface {

    public init(window: UIWindow) {
        self.window = window
    }
    
    public func setWelcome() {
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
