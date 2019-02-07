//
//  SearchFriendsWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

final class SearchFriendsWireframe: AppWireframe, SearchFriendsWireframeInterface {
    
    func pushFriendProfile(userId: String) {
        
        let controller = FriendProfileViewController()
        let wireframe = FriendProfileWireframe(navigationController: self.navigationController)
        let presenter = FriendProfilePresenter(view: controller, interactor: ProfileInteractor.shared, wireframe: wireframe, userId: userId)
        controller.presenter = presenter
        self.show(controller, with: .push, animated: true)
    }
}
