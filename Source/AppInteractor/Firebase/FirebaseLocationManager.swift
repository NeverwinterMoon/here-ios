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

//    public func getLocationOfFriends(userLocation: CLLocationCoordinate2D) -> Single<[User]> {
//        return self.friends()
//            .map { friends in
//                return friends.filter { [unowned self] friend -> Bool in
//                    var distMeters: Double? = nil
//                    self.ref.child("users/\(friend.id)/location").observeSingleEvent(of: .value, with: { (snapshot) in
//                        let coordinate = snapshot.value as? NSDictionary
//
//                        guard let latitude = coordinate?["latitude"] as? Double, let longitude = coordinate?["longitude"] as? Double else {
//                            return
//                        }
//
//                        let location = CLLocation(latitude: latitude, longitude: longitude)
//                        distMeters = location.distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
//                    })
//
//                    return distMeters != nil ? distMeters! <= Double(1000) : false
//                }
//            }
//    }
    public func getNearbyFriends() -> Single<[User]> {
        return self.activatedUser()
            .map { [unowned self] user -> [String] in
                var friendsId = [String]()
                self.ref.child("users/\(user.id)/nearby_friends").observe(.value, with: { snapshot in
                    guard let ids = snapshot.value as? [String] else {
                        return
                    }
                    friendsId = ids
                })
                return friendsId
            }
            .map { friendsId in
                var friends: [User] = []
                friendsId.forEach { friendId in
                    API.User.Get(userId: friendId).asSingle().asObservable()
                        .subscribe(onNext: {
                            friends.append($0)
                        })
                        .disposed(by: self.disposeBag)
                }
                return friends
            }
    }

    public func friends() -> Single<[User]> {
        return self.activatedUser()
            .flatMap { me -> Single<[User]> in
                API.User.GetFriends(username: me.id).asSingle()
        }
    }
    
    public func sendLocation(location: CLLocationCoordinate2D) {
        self.activatedUser()
            .map { $0.id }
            .asObservable()
            .subscribe(onNext: {
                let newData = ["latitude": location.latitude, "longitude": location.longitude]
                self.ref.child("users/\($0)/location").setValue(newData)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
