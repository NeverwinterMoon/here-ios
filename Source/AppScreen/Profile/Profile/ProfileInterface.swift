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

protocol ProfileViewInterface: ViewInterface {
    var tapEditProfile: Signal<Void> { get }
    var tapFriends: Signal<Void> { get }
}

protocol ProfileInteractorInterface: class {
    func user(userId: String)
    func activatedUser() -> Single<User>
}

extension ProfileInteractor: ProfileInteractorInterface {}

protocol ProfilePresenterInterface: class {
    var username: Driver<String> { get }
    var userDisplayName: Driver<String> { get }
    var profileImageURL: Driver<URL> { get }
    var selfIntroduction: Driver<String?> { get }
}

protocol ProfileWireframeInterface: WireframeInterface {
    func presentUserInfo()
    func pushfFriendsList()
}
