//
//  EditProfileInfoPresenter.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class EditProfileInfoPresenter: EditProfileInfoPresenterInterface {
    
    let infoToChange: Driver<String>
    let currentInfo: Driver<String>

    init(view: EditProfileInfoViewInterface, interactor: EditProfileInfoInteractorInterface, wireframe: EditProfileInfoWireframeInterface, infoType: userInfoType, currentContent: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.infoToChange = Driver<String>.just(infoType.displayTitle)
        self.currentInfo = Driver<String>.just(currentContent)
        
//        self.view.viewWillDisappear
//            .flatMap { [unowned self] in
//                self.interactor.activatedUser()
//            }
//            .subscribe(onNext: { [unowned self] user in
//                self.interactor.user(userId: user.id)
//            })
//            .disposed(by: self.disposeBag)

        self.view.tapSaveProfileInfo
            .asObservable()
            .flatMap { [unowned self] newInfo -> Single<Void> in
                self.interactor.updateProfile(params: [infoType.paramsKey: newInfo])
            }
            .subscribe(onNext: { [unowned self] in
                self.wireframe.popBackToDetailProfileInfo()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: EditProfileInfoViewInterface
    private let interactor: EditProfileInfoInteractorInterface
    private let wireframe: EditProfileInfoWireframeInterface
    private let disposeBag = DisposeBag()
}
