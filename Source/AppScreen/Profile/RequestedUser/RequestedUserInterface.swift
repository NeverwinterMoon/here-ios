//
//  RequestedUserInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppInteractor

protocol RequestedUserViewInterface: class {
}

protocol RequestedUserInteractorInterface: class {
}

extension ProfileInteractor: RequestedUserInteractorInterface {}

protocol RequestedUserPresenterInterface: class {
}

protocol RequestedUserWireframeInterface: class {
}
