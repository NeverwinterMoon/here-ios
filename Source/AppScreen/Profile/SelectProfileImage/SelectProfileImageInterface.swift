//
//  SelectProfileImageInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/21.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa

protocol SelectProfileImageViewInterface: class {
}

protocol SelectProfileImagePresenterInterface: class {
    func loadCamera()
    func selectProfileImageFromCameraRoll()
}

protocol SelectProfileImageWireframeInterface {
    func loadCamera()
    func selectProfileImageFromCameraRoll()
}
