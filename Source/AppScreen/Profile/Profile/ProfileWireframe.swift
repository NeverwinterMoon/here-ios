//
//  ProfileWireframe.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class ProfileWireframe: AppWireframe, ProfileWireframeInterface {
    
    func presentUserInfo(userId: String) {
        let controller = UserInfoViewController()
        let wireframe = UserInfoWireframe(navigationController: navigationController)
        let presenter = UserInfoPresenter(
            userId: userId,
            view: controller,
            interactor: ProfileInteractor(),
            wireframe: wireframe
        )
        controller.presenter = presenter
        show(controller, with: .present, animated: true)
    }
    
    func pushfFriendsList(myId: String) {
    }
}
