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
        
        guard let window = UIApplication.shared.delegate?.window else {
            return
        }
        
        let tabBarController = AppTabBarController()
        tabBarController.selectedIndex = 1
        window?.rootViewController = tabBarController
        
        if let navigationController = tabBarController.viewControllers?[1] as? UINavigationController {
            let controller = ChatRoomViewController()
            let wireframe = ChatRoomWireframe(navigationController: self.navigationController)
            let presenter = ChatRoomPresenter(view: controller, interactor: ChatInteractor.shared, wireframe: wireframe, with: userId)
            controller.presenter = presenter
            navigationController.pushViewController(controller, animated: true)
        }
        window?.makeKeyAndVisible()
    }
}
