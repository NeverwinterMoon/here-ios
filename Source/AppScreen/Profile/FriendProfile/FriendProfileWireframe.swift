//
//  FriendProfileWireframe.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import AppUIKit

final class FriendProfileWireframe: AppWireframe, FriendProfileWireframeInterface {
    
    func pushChatRoom(userId: String) {
        
        guard let window = UIApplication.shared.delegate?.window, let tabBarController = window?.rootViewController as? UITabBarController else {
            return
        }
        tabBarController.selectedIndex = 1
        
        guard let navigationController = tabBarController.viewControllers?[1] as? UINavigationController else {
            return
        }

        let controller = ChatRoomViewController()
        let wireframe = ChatRoomWireframe(navigationController: navigationController)
        let presenter = ChatRoomPresenter(view: controller, interactor: ChatInteractor.shared, wireframe: wireframe, with: userId)
        controller.presenter = presenter
        navigationController.pushViewController(controller, animated: true)
        print(navigationController.viewControllers)
    }
}
