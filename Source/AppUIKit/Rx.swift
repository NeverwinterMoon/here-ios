//
//  Rx.swift
//  AppUIKit
//
//  Created by 服部穣 on 2018/12/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    
    public var viewDidLoad: ControlEvent<Void> {
        return ControlEvent(events: sentMessage(#selector(base.viewDidLoad)).map { _ in })
    }
    
    public var viewWillAppear: ControlEvent<Void> {
        return ControlEvent(events: sentMessage(#selector(base.viewWillAppear)).map { _ in })
    }
    
    public var viewDidAppear: ControlEvent<Void> {
        return ControlEvent(events: sentMessage(#selector(base.viewDidAppear)).map { _ in })
    }
    
    public var viewWillDisappear: ControlEvent<Void> {
        return ControlEvent(events: sentMessage(#selector(base.viewWillDisappear)).map { _ in })
    }
    
    public var viewDidDisappear: ControlEvent<Void> {
        return ControlEvent(events: sentMessage(#selector(base.viewDidDisappear)).map { _ in })
    }
}
