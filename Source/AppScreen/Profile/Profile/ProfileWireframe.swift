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
        
        let controller = DetailProfileInfoViewController()
        let wireframe = DetailProfileInfoWireframe(navigationController: self.navigationController)
        let presenter = DetailProfileInfoPresenter(
            view: controller,
            interactor: ProfileInteractor(),
            wireframe: wireframe
        )
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
    
    func pushfFriendsList() {
        
        let controller = FriendsListViewController()
        let wireframe = FriendsListWireframe(navigationController: self.navigationController)
        let presenter = FriendsListPresenter(
            view: controller,
            interactor: ProfileInteractor.shared,
            wireframe: wireframe
        )
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
    
    func pushSearchFriends() {
        
        let controller = SearchFriendsViewController()
        let wireframe = SearchFriendsWireframe(navigationController: self.navigationController)
        let presenter = SearchFriendsPresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
    
    func pushRequestedUsers() {
        let controller = RequestedUserViewController()
        let wireframe = RequestedUserWireframe(navigationController: self.navigationController)
        let presenter = RequestedUserPresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe)
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
}
