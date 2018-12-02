//
//  FriendsListInterface.swift
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

protocol FriendsListViewInterface {
    var tapFriend: Signal<IndexPath> { get }
}

protocol FriendsListInteractorInterface: class {
    func friends() -> Single<[User]>
}

extension ProfileInteractor: FriendsListInteractorInterface {}

protocol FriendsListPresenterInterface: class {
    var sections: Driver<[FriendsListSection]> { get }
}

protocol FriendsListWireframeInterface: WireframeInterface {
    func pushFriendInfo(userId: String)
}
