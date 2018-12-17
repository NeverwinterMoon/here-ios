//
//  EditUserInfoWireframe.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class EditUserInfoWireframe: AppWireframe, EditUserInfoWireframeInterface {
    
    func showChangeProfileImageActionSheet() {
    }
    
    func pushEditProfileInfo(infoInChange: String, currentContent: String) {
        
        let controller = ChangeProfileInfoViewController()
        let wireframe = ChangeProfileInfoWireframe(navigationController: self.navigationController)
        let presenter = ChangeProfileInfoPresenter(
            view: controller,
            interactor: ProfileInteractor.shared,
            wireframe: wireframe,
            infoInChangeInString: infoInChange,
            currentContent: currentContent
        )
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
}
