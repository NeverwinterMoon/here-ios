//
//  RequestedUserInterface.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppInteractor
import RxCocoa
import RxSwift

protocol RequestedUserViewInterface: class {
    var tapApproveRequest: Signal<IndexPath> { get }
    var tapDeclineRequest: Signal<IndexPath> { get }
}

protocol RequestedUserInteractorInterface: class {
    func requestsReceiving() -> Single<[User]>
    func declineRequest(userId: String)
    func approveRequest(userId: String)
}

extension ProfileInteractor: RequestedUserInteractorInterface {}

protocol RequestedUserPresenterInterface: class {
    var sections: Driver<[RequestedUserSection]> { get }
}

protocol RequestedUserWireframeInterface: class {
}
