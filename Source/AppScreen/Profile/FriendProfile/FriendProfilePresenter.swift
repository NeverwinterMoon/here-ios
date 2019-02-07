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
    var buttonState: RelationState
    
    init(view: FriendProfileViewInterface, interactor: FriendProfileInteractorInterface, wireframe: FriendProfileWireframeInterface, userId: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.user = self.interactor.getUser(userId: userId).asDriver(onErrorJustReturn: .init())
        
        self.userIntro = self.user.map{ $0.selfIntroduction }
        self.username = self.user.map { $0.username }
        self.userDisplayName = self.user.map { $0.userDisplayName }
        self.userProfileURL = self.user.map { $0.profileImageURL }
        self.buttonState = .notFriend
        
        self.relation = userRelation(interactor: self.interactor, userId: userId).asDriver(onErrorJustReturn: .notFriend)
        // TODO: also implement blocked user
        
        Observable.zip(self.view.tapFriendRequest.asObservable(), self.relation.asObservable())
            .flatMap { (_, state) -> Single<Void> in
                switch state {
                case .friend:
                    // show the sheet (block, mute)
                    return Single.just(())
                case .notFriend:
                    // change the button status to pending
                    self.view.buttonState = .requesting
                    return self.interactor.friendRequest(to: userId)
                case .requesting:
                    // change the button status to notFriend
                    self.view.buttonState = .notFriend
                    return self.interactor.cancelRequest(to: userId)
                case .requested:
                    self.view.buttonState = .friend
                    return self.interactor.approveRequest(userId: userId)
                case .blocking:
                    // show the cheet (unblock)
                    return Single.just(())
                case .blocked:
                    return Single.just(())
                }
            }
            .subscribe()
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private var view: FriendProfileViewInterface
    private let interactor: FriendProfileInteractorInterface
    private let wireframe: FriendProfileWireframeInterface
    private let disposeBag = DisposeBag()
}

fileprivate func userRelation(interactor: FriendProfileInteractorInterface, userId: String) -> Observable<RelationState> {
    return Observable.zip(interactor.friends().asObservable(), interactor.requestsOfUser().asObservable())
        .map { (friends, friendPendings) -> RelationState in
            if friends.first(where: { $0.id == userId }) != nil {
                return .friend
            } else if friendPendings.first(where: { $0.userId == userId }) != nil {
                return .requested
            } else if friendPendings.first(where: { $0.withUserId == userId }) != nil {
                return .requesting
                // TODO: block, blocking
            } else {
                return .notFriend
            }
    }
}

enum RelationState {
    case friend
    case notFriend
    case requesting
    case requested
    case blocking
    case blocked
}
