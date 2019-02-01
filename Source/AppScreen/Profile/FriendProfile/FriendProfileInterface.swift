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
    func user(userId: String)
}

extension ProfileInteractor: FriendProfileInteractorInterface {}

protocol FriendProfilePresenterInterface {
}

protocol FriendProfileWireframeInterface {
    func pushFriendsList(userId: String)
}
