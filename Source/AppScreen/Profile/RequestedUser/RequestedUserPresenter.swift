//
//  RequestedUserPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxSwift

final class RequestedUserPresenter: RequestedUserPresenterInterface {
    
    var sections: Driver<[RequestedUserSection]> {
        return self.sectionsRelay.asDriver()
    }
    private let sectionsRelay: BehaviorRelay<[RequestedUserSection]> = .init(value: [])
    
    init(view: RequestedUserViewInterface, interactor: RequestedUserInteractorInterface, wireframe: RequestedUserWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.interactor.requestsReceiving()
            .asObservable()
            .mapSections()
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: RequestedUserViewInterface
    private let interactor: RequestedUserInteractorInterface
    private let wireframe: RequestedUserWireframeInterface
    private let disposeBag = DisposeBag()
}

extension Observable where E == [User] {
    fileprivate func mapSections() -> Observable<[RequestedUserSection]> {
        return self.map { users -> [RequestedUserSection] in
            let items = users.map {
                RequestedUserItem(userId: $0.id, profileImageURL: $0.profileImageURL, username: $0.username, userDisplayName: $0.userDisplayName)
            }
            return [RequestedUserSection(items: items)]
        }
    }
}