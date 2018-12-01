//
//  SharedDBMaganer.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/01.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift

public final class SharedDBManager {
    
    static func shared() -> Realm {
        return try! Realm()
    }
    
    private init() {}
}
