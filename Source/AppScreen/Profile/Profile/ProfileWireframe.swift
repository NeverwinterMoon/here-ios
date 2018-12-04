//
//  ProfileWireframe.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import AppUIKit

final class ProfileWireframe: AppWireframe, ProfileWireframeInterface {
    
    func presentUserInfo() {
        
        let controller = EditUserInfoViewController()
        let wireframe = EditUserInfoWireframe(navigationController: self.navigationController)
        let presenter = EditUserInfoPresenter(
            view: controller,
            interactor: ProfileInteractor(),
            wireframe: wireframe
        )
        controller.presenter = presenter
        show(controller, with: .push, animated: true)
    }
    
    func pushfFriendsList() {
        
        let controller = FriendsListViewController()
        let wireframe = FriendsListWireframe(navigationController: self.navigationController)
        let presenter = FriendsListPresenter(
            view: controller,
            interactor: ProfileInteractor(),
            wireframe: wireframe
        )
        controller.presenter = presenter
        show(controller, with: .present, animated: true)
    }
}
