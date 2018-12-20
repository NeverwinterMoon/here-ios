//
//  Interface.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppUIKit
import RxCocoa
import RxSwift

public protocol ViewInterface {
    var viewDidLoad: ControlEvent<Void> { get }
    var viewWillAppear: ControlEvent<Void> { get }
    var viewDidAppear: ControlEvent<Void> { get }
    var viewWillDisappear: ControlEvent<Void> { get }
    var viewDidDisappear: ControlEvent<Void> { get }
}

public extension ViewInterface where Self: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        return rx.viewDidLoad
    }
    
    var viewWillAppear: ControlEvent<Void> {
        return rx.viewWillAppear
    }
    
    var viewDidAppear: ControlEvent<Void> {
        return rx.viewDidAppear
    }
    
    var viewWillDisappear: ControlEvent<Void> {
        return rx.viewWillDisappear
    }
    
    var viewDidDisappear: ControlEvent<Void> {
        return rx.viewDidDisappear
    }
}
