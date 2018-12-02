//
//  RootInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/30.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions
import RxCocoa
import RxSwift

public final class RootInteractor: Disposer {
    
    public enum State {
        case loggedIn
        case loggedOut
    }
    
    public var state: Observable<State> {
        
        return self.stateSubject.asObservable()
    }
    private var stateSubject: BehaviorSubject<State> = .init(value: .loggedOut)
}
