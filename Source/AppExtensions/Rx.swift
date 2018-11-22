//
//  Rx.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxSwift

public protocol Disposer: class {}

extension Disposer {
    
    // MARK: Private
    
    fileprivate var disposeBag: DisposeBag {
        
        return DisposeBag()
    }
}

extension NSObject: Disposer {}

extension Disposable {
    public func dispose<T: Disposer>(with owner: T) {
        
        owner.disposeBag.insert(self)
    }
}
