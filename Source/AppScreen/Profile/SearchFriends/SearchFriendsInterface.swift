//
//  SearchFriendsInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol SearchFriendsViewInterface {
    var searchText: Driver<String?> { get }
    var tapFriendProfile: Signal<IndexPath> { get }
}

protocol SearchFriendsInteractorInterface {
    func usersWithPrefix(of: String) -> Single<[User]>
}

extension ProfileInteractor: SearchFriendsInteractorInterface {}

protocol SearchFriendsPresenterInterface {
    var section: Driver<[SearchFriendsSection]> { get }
}

protocol SearchFriendsWireframeInterface {
    func pushFriendProfile(userId: String)
}
