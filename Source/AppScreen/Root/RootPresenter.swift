//
//  RootPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/02.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppExtensions

final class RootPresenter: Disposer {
    
    public init(wireframe: RootWireframeInterface, interactor: RootInteractorInterface) {
        
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    // MARK: - Private
    private let wireframe: RootWireframeInterface
    private let interactor: RootInteractorInterface
}
