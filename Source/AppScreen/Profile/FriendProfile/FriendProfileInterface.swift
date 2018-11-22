//
//  FriendProfileInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxSwift

protocol FriendProfileViewInterface {
    var tapFriends: Signal<Void> { get }
}

protocol FriendProfileInteractorInterface {
    func friendsOf(userId: String) -> Single<[User]>
}

//extension

protocol FriendProfilePresenterInterface {
    var userId: Driver<String> { get }
}

protocol FriendProfileWireframeInterface {
    func pushFriendsList(userId: String)
}
