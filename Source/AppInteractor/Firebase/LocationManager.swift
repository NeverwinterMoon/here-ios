//
//  LocationManager.swift
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

public final class LocationManager {
    
    public static let shared = LocationManager()
    
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

    public func getLocationOfFriends(userLocation: CLLocationCoordinate2D) -> Single<[User]> {
        return self.friends()
            .map { friends in
                return friends.filter { [unowned self] friend -> Bool in
                    var distMeters: Double? = nil
                    self.ref.child("users/\(friend.id)/location").observeSingleEvent(of: .value, with: { (snapshot) in
                        let coordinate = snapshot.value as? NSDictionary

                        guard let latitude = coordinate?["latitude"] as? Double, let longitude = coordinate?["longitude"] as? Double else {
                            return
                        }

                        let location = CLLocation(latitude: latitude, longitude: longitude)
                        distMeters = location.distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
                    })

                    return distMeters != nil ? distMeters! <= Double(1000) : false
                }
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
