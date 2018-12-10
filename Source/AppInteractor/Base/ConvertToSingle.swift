//
//  ConvertToSingle.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/25.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppRequest
import RxSwift

extension AppTargetType {
    
    public func asSingle() -> Single<ElementType> {
        
        return self.primitiveSequence.asObservable().asSingle()
    }
}
