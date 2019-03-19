//
//  CreateNewAccountWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class CreateNewAccountWireframe: AppWireframe, CreateNewAccountWireframeInterface {
    
    func pushAppTabBarController() {
        RootWireframe.shared.setRootTabBar(loggedIn: true)
    }
    
    func showCreateNewAccountAgain() {
        let controller = CreateNewAccountViewController()
        self.navigationController.viewControllers.removeLast()
        let wireframe = CreateNewAccountWireframe(navigationController: self.navigationController)
        let presenter = CreateNewAccountPresenter(view: controller, interactor: WelcomeInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.show(controller, with: .push, animated: false)
    }
}
