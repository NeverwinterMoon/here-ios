//
//  ProfileInterface.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol ProfileViewInterface {
    var tapEditProfile: Signal<Void> { get }
    var tapFriends: Signal<Void> { get }
}

protocol ProfileInteractorInterface: class {
    func user(userId: String) -> Single<User>
}

extension ProfileInteractor: ProfileInteractorInterface {}

protocol ProfilePresenterInterface: class {
    var profileImageURL: Driver<URL> { get }
    var profileIntro: Driver<String> { get }
    var friendsCount: Driver<Int> { get }
}

protocol ProfileWireframeInterface: WireframeInterface {
    func presentUserInfo(userId: String)
    func pushfFriendsList(userId: String)
}
