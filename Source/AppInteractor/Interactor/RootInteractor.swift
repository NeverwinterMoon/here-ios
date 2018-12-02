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

public final class RootInteractor: Disposer {
    
    public enum State {
        case hasAccount
        case noAccount
    }
    
    public var state: Observable<State> {
        
        return self.stateSubject.asObservable()
    }
    
    private var stateSubject: BehaviorSubject<State> = .init(value: .noAccount)
    
    private init() {

        SharedDBManager.activatedId
            .asObservable()
            .distinctUntilChanged()
            .flatMap { userId -> Single<Realm?> in
                guard userId != nil else {
                    return .just(nil)
                }
                return SharedDBManager.activatedAccount()
                    .map { realm -> Realm? in realm }
            }
            .flatMapLatest { realm -> Observable<State> in
                guard let realm = realm else {
                    return Observable.just(.noAccount)
                }
                return Observable.collection(from: realm.objects(Me.self))
                    .map { $0.first == nil ? .noAccount : .hasAccount }
            }
            .distinctUntilChanged()
            .bind(to: stateSubject)
            .dispose(with: self)
    }
}
