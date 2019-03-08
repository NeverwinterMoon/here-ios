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
import SwiftDate

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
            // Next: ここを正しくかく
            .map { ids -> [String] in
                var nearbyFriendIds = [String]()
                ids.forEach { id in
                    self.ref.child("users/\(id)/updated_at")
                        .rx
                        .observeSingleEvent(.value)
                        .asObservable()
                        .subscribe(onNext: { snapshot in
                            if let updatedAtString = snapshot.value as? String {
                                guard let updatedAt = updatedAtString.toISODate() else {
                                    assertionFailure("failed to parse Date")
                                    return
                                }
                                let tokyo = Region(calendar: Calendar(identifier: .gregorian), zone: Zones.asiaTokyo, locale: Locales.japaneseJapan)
                                let now = DateInRegion(Date(), region: tokyo)
                                if let hourDif = (now.date - updatedAt.date).hour, hourDif <= 3 {
                                    nearbyFriendIds.append(id)
                                }
                            }
                        })
                }
                return nearbyFriendIds
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
