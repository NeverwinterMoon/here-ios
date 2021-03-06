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
    
    var isRequestEmpty: Driver<Bool> {
        return self.isRequestEmptyRelay.asDriver()
    }
    private let isRequestEmptyRelay: BehaviorRelay<Bool> = .init(value: false)
    
    init(view: RequestedUserViewInterface, interactor: RequestedUserInteractorInterface, wireframe: RequestedUserWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.view.tapApproveRequest
            .map { [unowned self] in
                self.sectionsRelay.value[$0.section].items[$0.item].userId
            }
            .asObservable()
            .flatMap { [unowned self] in
                self.interactor.approveRequest(userId: $0)
            }
            .subscribe(onNext: { [unowned self] in
                self.reload()
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapDeclineRequest
            .map { [unowned self] in
                self.sectionsRelay.value[$0.section].items[$0.item].userId
            }
            .asObservable()
            .flatMap { [unowned self] in
                self.interactor.declineRequest(userId: $0)
            }
            .subscribe(onNext: { [unowned self] in
                self.reload()
            })
            .disposed(by: self.disposeBag)

        self.interactor.requestsReceiving()
            .asObservable()
            .mapSections()
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)
        
        self.interactor.requestsReceiving()
            .asObservable()
            .map { $0.isEmpty }
            .bind(to: self.isRequestEmptyRelay)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: RequestedUserViewInterface
    private let interactor: RequestedUserInteractorInterface
    private let wireframe: RequestedUserWireframeInterface
    private let disposeBag = DisposeBag()
    
    private func reload() {
        self.interactor.requestsReceiving()
            .asObservable()
            .mapSections()
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)
        
        self.interactor.requestsReceiving()
            .asObservable()
            .map { $0.isEmpty }
            .bind(to: self.isRequestEmptyRelay)
            .disposed(by: self.disposeBag)
    }
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
