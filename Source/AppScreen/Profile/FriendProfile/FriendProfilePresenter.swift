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

        self.view.tapRelation.asObservable()
            .flatMap { [unowned self] in
                self.interactor.getRelationWith(userId: userId)
            }
            .subscribe(onNext: { state in
                switch state {
                case .friend:
                    //TODO: show the sheet (block, mute)
                    print("notyet")
                case .notFriend:
                    self.view.buttonState = .requesting
                    self.interactor.friendRequest(to: userId)
                case .requesting:
                    self.view.buttonState = .notFriend
                    self.interactor.cancelRequest(to: userId)
                case .requested:
                    // TODO: clean here up
                    self.view.buttonState = .friend
                    self.interactor.approveRequest(userId: userId)
                case .blocking:
                    //TODO: show the sheet (unblock)
                    print("notyet")
                case .blocked:
                    // TODO:
                    print("notyet")
                }
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapChatButton
            .emit(onNext: { [unowned self] in
                self.wireframe.pushChatRoom(userId: userId)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private var view: FriendProfileViewInterface
    private let interactor: FriendProfileInteractorInterface
    private let wireframe: FriendProfileWireframeInterface
    private let disposeBag = DisposeBag()
}
