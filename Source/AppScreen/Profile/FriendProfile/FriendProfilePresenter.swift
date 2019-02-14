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
    var userProfileImage: Driver<Data?> {
        return self.userProfileImageRelay.asDriver()
    }
    private let userProfileImageRelay: BehaviorRelay<Data?> = .init(value: nil)

    var relation: Driver<RelationState>
    var buttonState: RelationState
    
    init(view: FriendProfileViewInterface, interactor: FriendProfileInteractorInterface, wireframe: FriendProfileWireframeInterface, userId: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user: Driver<User> = self.interactor.getUser(userId: userId).asDriver(onErrorJustReturn: .init())
        
        self.userIntro = user.map{ $0.selfIntroduction }
        self.username = user.map { $0.username }
        self.userDisplayName = user.map { $0.userDisplayName }
        self.buttonState = .notFriend

        self.relation = self.interactor.getRelationWith(userId: userId).asDriver(onErrorJustReturn: .notFriend)
        // TODO: also implement blocked user
        
        user.asObservable()
            .map { user -> String in
                if let url = user.profileImageURL {
                    return "/users/\(user.id)/profile_image_url/\(url).jpg"
                } else {
                    return "default.jpg"
                }
            }
            .flatMap {
                FirebaseStorageManager.downloadFile(filePath: $0)
            }
            .bind(to: self.userProfileImageRelay)
            .disposed(by: self.disposeBag)

        self.view.tapFriendRequest.asObservable()
            .flatMap { [unowned self] in
                self.interactor.getRelationWith(userId: userId)
            }
            .flatMap { state -> Single<Void> in
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
                    self.view.buttonState = .requested
                    return self.interactor.approveRequest(userId: userId)
                case .blocking:
                    // show the sheet (unblock)
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
