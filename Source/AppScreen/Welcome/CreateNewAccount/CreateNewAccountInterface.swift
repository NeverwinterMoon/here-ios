//
//  CreateNewAccountInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol CreateNewAccountViewInterface {
    var tapCreateAccount: Signal<Void> { get }
}

protocol CreateNewAccountInteractorInterface {
}

protocol CreateNewAccountWireframeInterface {
}
