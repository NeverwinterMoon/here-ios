//
//  CameraRollViewModel.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class CameraRollPresenter: CameraRollPresenterInterface {
    
    init(view: CameraRollViewInterface, wireframe: CameraRollWireframeInterface) {
        
        self.view = view
        self.wireframe = wireframe
    }
    
    // MARK: - Private
    private let view: CameraRollViewInterface
    private let wireframe: CameraRollWireframeInterface
}
