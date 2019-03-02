//
//  LocationManager.swift
//  NowHere
//
//  Created by 服部穣 on 2019/03/02.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import FirebaseFirestore

public final class LocationManager {
    
    public static let shared = LocationManager()
    
    private var db: Firestore!
    
    private init() {
        
        self.db = Firestore.firestore()
        self.db.settings = FirestoreSettings()
    }
    
    public func sendLocation(location: [String: Any]) {
        self.db.collection("users").addDocument(data: location)
    }
    
    public func getLocationOfFriends() {
        
    }
}
