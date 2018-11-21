//
//  ProfileWireframe.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class ProfileWireframe: AppWireframe, ProfileWireframeInterface {
    
    func pushUserInfo() {
        let controller = UserInfoViewController()
        let wireframe = UserInfoWireframe(navigationController: navigationController)
    }
    
    func pushfFriendsList(myId: String) {
        <#code#>
    }
}
