//
//  RootInteractor.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/11/30.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppExtensions
import RealmSwift
import RxCocoa
import RxRealm
import RxSwift

public final class RootInteractor {
    
    public static let shared = RootInteractor()
    
    public enum State {
        case hasAccount
        case noAccount
    }
    
    public var state: Observable<State> {
        
        return self.stateSubject.asObservable()
    }
    
    private let stateSubject: BehaviorSubject<State> = .init(value: .noAccount)
    
    private init() {

        // TODO: activatedId or loggedInUserIds??
        SharedDBManager.loggedInUserIds
            .asObservable()
            .distinctUntilChanged()
            .map { ids -> State in
                guard ids != [] else {
                    return .noAccount
                }
                return .hasAccount
            }
            .distinctUntilChanged()
            .bind(to: stateSubject)
            .disposed(by: self.disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}
