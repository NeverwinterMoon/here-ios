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
    
    let infoInChange: Driver<String>
    let currentInfo: Driver<String>

    init(view: EditProfileInfoViewInterface, interactor: EditProfileInfoInteractorInterface, wireframe: EditProfileInfoWireframeInterface, infoToChange: String, currentContent: String) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.infoInChange = Driver<String>.just(infoToChange)
        self.currentInfo = Driver<String>.just(currentContent)
        
        self.view.tapSaveProfileInfo
            .asObservable()
            .flatMap { [unowned self] newInfo -> Single<Void> in
                self.interactor.updateProfileInfo(params: [infoToChange: newInfo])
            }
            .subscribe(onNext: {
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
