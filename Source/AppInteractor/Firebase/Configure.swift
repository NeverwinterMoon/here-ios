//
//  Configure.swift
//  NowHere
//
//  Created by 服部穣 on 2018/12/24.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

public func configureFirebaseApp() {
    print()
    print("called")
    print()
    FirebaseApp.configure()
    let db = Firestore.firestore()
    print()
    print(db)
    print()
}
