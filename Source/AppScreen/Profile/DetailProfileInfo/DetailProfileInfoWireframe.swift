//
//  DetailProfileInfoWireframe.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class DetailProfileInfoWireframe: AppWireframe, DetailProfileInfoWireframeInterface {
    
    func showChangeProfileImageActionSheet() {
    }
    
    func pushEditProfileInfo(infoType: userInfoType, currentContent: String) {
        
        let controller = EditProfileInfoViewController()
        let wireframe = EditProfileInfoWireframe(navigationController: self.navigationController)
        let presenter = EditProfileInfoPresenter(
            view: controller,
            interactor: ProfileInteractor.shared,
            wireframe: wireframe,
            infoType: infoType,
            currentContent: currentContent
        )
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
}
