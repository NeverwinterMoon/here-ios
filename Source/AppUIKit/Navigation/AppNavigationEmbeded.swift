//
//  AppNavigationEmbeded.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

public protocol AppNavigationControllerEmbeded {
    
    var isNavigationBarHidden: Bool { get }
}

extension AppNavigationControllerEmbeded {
    
    public var isNavigationBarHidden: Bool {
        return false
    }
}
