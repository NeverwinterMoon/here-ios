//
//  FriendProfileInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol FriendProfileViewInterface: ViewInterface {
    var tapFriends: Signal<Void> { get }
}

protocol FriendProfileInteractorInterface {
    func getUser(userId: String) -> Single<User>
    func friends() -> Single<[User]>
    func getProfileIcon(filePath: String) -> Single<UIImage>
}

extension ProfileInteractor: FriendProfileInteractorInterface {}

protocol FriendProfilePresenterInterface {
    var relation: Driver<RelationState> { get }
    var userIntro: Driver<String?> { get }
    var username: Driver<String> { get }
    var userDisplayName: Driver<String> { get }
    var userProfileURL: Driver<String?> { get }
}

protocol FriendProfileWireframeInterface {
    func pushFriendsList(userId: String)
}
