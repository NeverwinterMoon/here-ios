//
//  FirebaseLocationManager.swift
//  NowHere
//
//  Created by 服部穣 on 2019/03/02.
//  Copyright © 2019 服部穣. All rights reserved.
//

import CoreLocation
import Foundation
import AppEntity
import AppRequest
import FirebaseDatabase
import RxCocoa
import RxFirebaseDatabase
import RxSwift

public final class FirebaseLocationManager {
    
    public static let shared = FirebaseLocationManager()
    
    private var ref: DatabaseReference!

    private init() {
        self.ref = Database.database().reference()
    }
    
    public func activatedUser() -> Single<User> {
        return SharedDBManager.activatedAccountRealm()
            .map { realm -> User in
                return realm!.objects(User.self).first!
            }
            .asObservable()
            .asSingle()
    }

    public func getNearbyFriends() -> Single<[User]> {
        
        return self.activatedUser()
            .asObservable()
            .flatMap { [unowned self] user -> Observable<DataSnapshot> in
                self.ref.child("users/\(user.id)/nearby_friends")
                    .rx
                    .observeSingleEvent(.value)
            }
            .map { snapshot -> [String] in
                guard let ids = snapshot.value as? [String] else {
                    return []
                }
                return ids
            }
            .flatMap { ids -> Single<[User]> in
                
                if ids.isEmpty {
                    return Single.just([])
                } else {
                    return API.User.GetFriends(fromIds: ids).asSingle()
                }
            }
            .asSingle()
    }

    public func sendLocation(location: CLLocationCoordinate2D) {
        self.activatedUser()
            .map { $0.id }
            .asObservable()
            .subscribe(onNext: {
                let newData = ["latitude": location.latitude, "longitude": location.longitude]
                self.ref.child("users/\($0)/location").setValue(newData)
                self.ref.child("users/\($0)/updated_at").setValue("\(Date())")
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
