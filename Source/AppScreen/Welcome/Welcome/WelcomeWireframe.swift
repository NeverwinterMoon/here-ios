//
//  WelcomeWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class WelcomeWireframe: AppWireframe, WelcomeWireframeInterface {

    func pushCreateNewAccount() {
        
        let controller = CreateNewAccountViewController()
        let wireframe = CreateNewAccountWireframe(navigationController: self.navigationController)
        let presenter = CreateNewAccountPresenter(view: controller, interactor: WelcomeInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
    
    func pushLogin() {
        // present alert
    }
}
