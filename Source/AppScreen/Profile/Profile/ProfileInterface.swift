//
//  ProfileInterface.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ProfileViewInterface {
    var tapInfo: Signal<Void> { get }
    var tapFriends: Signal<Void> { get }
}

//protocol ProfileInteractorInterface {
//    <#requirements#>
//}

protocol ProfilePresenterInterface {
    var profileImageURL: Driver<URL> { get }
    var profileInfo: Driver<String> { get }
}

protocol ProfileWireframeInterface {
    func pushInfo()
    func pushfFriendsList(myId: String)
}
