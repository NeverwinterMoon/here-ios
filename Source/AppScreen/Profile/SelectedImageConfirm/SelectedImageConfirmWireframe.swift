//
//  SelectedImageConfirmWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/24.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class SelectedImageConfirmWireframe: AppWireframe, SelectedImageConfirmWireframeInterface {
    
    func selectImage() {
        
        let wireframe = DetailProfileInfoWireframe(navigationController: self.navigationController)
        let controller = DetailProfileInfoViewController()
        let presenter = DetailProfileInfoPresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.show(controller, with: .present, animated: true)
    }
    
    func popBack() {
        self.navigationController.navigationBar.isHidden = false
        self.navigationController.tabBarController?.tabBar.isHidden = false
        self.popFromNavigationController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
