//
//  CreateNewAccountWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class CreateNewAccountWireframe: AppWireframe, CreateNewAccountWireframeInterface {
    
    func pushAppTabBarController() {
        
        RootWireframe.shared.setRootTabBar(loggedIn: true)
    }
}
