//
//  RootInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/02.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import RxCocoa
import RxSwift

public protocol RootInteractorInterface {
    var state: Observable<RootInteractor.State> { get }
}

extension RootInteractor: RootInteractorInterface {}

public protocol RootWireframeInterface {
    func setRootTabBar()
    func setWelcome()
}
