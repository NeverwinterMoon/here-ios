//
//  FriendProfilePresenter.swift
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

final class FriendProfilePresenter: FriendProfilePresenterInterface {
    
    var userIntro: Driver<String?>
    var username: Driver<String>
    var userDisplayName: Driver<String>
    var userProfileURL: Driver<String?>
    let user: Driver<User>

    var relation: Driver<RelationState>
    
    init(view: FriendProfileViewInterface, interactor: FriendProfileInteractorInterface, wireframe: FriendProfileWireframeInterface, userId: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.user = self.interactor.getUser(userId: userId).asDriver(onErrorJustReturn: .init())
        
        self.userIntro = self.user.map{ $0.selfIntroduction }
        self.username = self.user.map { $0.username }
        self.userDisplayName = self.user.map { $0.userDisplayName }
        self.userProfileURL = self.user.map { $0.profileImageURL }
        
        self.relation = self.interactor.friends().map { friends -> RelationState in
                if friends.first(where: { $0.id == userId }) != nil {
                    return .friend
                } else {
                    return .notFriend
                }
            }
            .asDriver(onErrorJustReturn: .notFriend)
        
        // TODO: also implement blocked user
    }
    
    // MARK: - Private
    private let view: FriendProfileViewInterface
    private let interactor: FriendProfileInteractorInterface
    private let wireframe: FriendProfileWireframeInterface
    private let disposeBag = DisposeBag()
}

enum RelationState {
    case friend
    case notFriend
    case blocking
    case blocked
}
