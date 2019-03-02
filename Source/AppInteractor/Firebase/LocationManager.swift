//
//  LocationManager.swift
//  NowHere
//
//  Created by 服部穣 on 2019/03/02.
//  Copyright © 2019 服部穣. All rights reserved.
//

import AppEntity
import Foundation
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
    
    public func sendLocation(location: [String: Any]) {
        self.activatedUser()
            .map { $0.id }
            .asObservable()
            .subscribe(onNext: {
                self.ref.child("users/\($0)/location").setValue(location)
            })
            .disposed(by: self.disposeBag)
    }
    
    public func getLocationOfFriends() {
        
    }
    
    // MARK: - Private
    private let disposeBag = DisposeBag()
}
