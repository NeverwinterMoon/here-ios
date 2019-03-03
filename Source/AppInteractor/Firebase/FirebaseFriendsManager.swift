//
//  FirebaseFriendsManager.swift
//  AppInteractor
//
//  Created by 服部穣 on 2019/03/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppRequest
import Firebase
import FirebaseDatabase
import RxCocoa
import RxSwift

public final class FirebaseFriendsManager {
    
    private var ref: DatabaseReference!
    
    public static let shared = FirebaseFriendsManager()
    
    private init() {
        self.ref = Database.database().reference()
    }

    public func uploadFriendId() {
        ProfileInteractor.shared.activatedUser()
            .asObservable()
            .flatMap {
                API.User.GetFriends(username: $0.id).asSingle()
            }
            .withLatestFrom(ProfileInteractor.shared.activatedUser(), resultSelector: { (friends, user) -> ([AppEntity.User], String) in
                return (friends, user.id)
            })
            .subscribe(onNext: { [unowned self] (friends, userId) in
                let newData = ["friend_ids": friends.map { $0.id }]
                self.ref.child("users/\(userId)/friends").setValue(newData)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
