//
//  ProfileInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxSwift

public final class ProfileInteractor {
    
    public static let shared = ProfileInteractor()

    public init() { }
    
    public func user(userId: String) -> Single<User> {
        
    }
}
