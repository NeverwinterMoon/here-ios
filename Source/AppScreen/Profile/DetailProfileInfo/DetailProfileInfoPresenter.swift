//
//  DetailProfileInfoPresenter.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import AppUIKit
import AppInteractor
import RxCocoa
import RxOptional
import RxSwift

final class DetailProfileInfoPresenter: DetailProfileInfoPresenterInterface {
    
    let userProfileImage: Driver<UIImage>
    var sections: Driver<[EditProfileInfoSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[EditProfileInfoSection]> = .init(value: [])

    init(view: DetailProfileInfoViewInterface, interactor: DetailProfileInfoInteractorInterface, wireframe: DetailProfileInfoWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        self.userProfileImage = self.interactor.getSelfProfileImage().asDriver(onErrorJustReturn: UIImage())
        
        self.view.viewWillAppear
            .do(onNext: {
                self.view.update()
            })
            .flatMap { [unowned self] in
                self.interactor
                    .activatedUser()
                    .asObservable()
                    .mapSections()
            }
            .bind(to: self.sectionsRelay)
            .disposed(by: self.disposeBag)

        self.view.tapEditProfileRow
            .map { [unowned self] in
                self.sectionsRelay.value[$0.section].items[$0.item]
            }
            .emit(onNext: { [unowned self] in
                self.wireframe.pushEditProfileInfo(infoType: $0.type, currentContent: $0.body)
            })
            .disposed(by: self.disposeBag)
        
        self.view.tapChangeProfileImage
            .emit(onNext: { [unowned self] in
                self.wireframe.showChangeProfileImageActionSheet()
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: DetailProfileInfoViewInterface
    private let interactor: DetailProfileInfoInteractorInterface
    private let wireframe: DetailProfileInfoWireframeInterface
    private let disposeBag = DisposeBag()
}

fileprivate extension Observable where E == User {
    
    fileprivate func mapSections() -> Observable<[EditProfileInfoSection]> {
        
        return self.map {
            
            // TODO: make this dry (use map or sth)
            var items: [DetailProfileInfoItem] = []
            items.append(DetailProfileInfoItem(type: userInfoType(infoType: .userDisplayName), body: $0.userDisplayName))
            items.append(DetailProfileInfoItem(type: userInfoType(infoType: .username), body: $0.username))
            items.append(DetailProfileInfoItem(type: userInfoType(infoType: .email), body: $0.email))
            items.append(DetailProfileInfoItem(type: userInfoType(infoType: .selfIntroduction), body: $0.selfIntroduction ?? ""))
            let sections = [EditProfileInfoSection(header: "プロフィール", items: items)]
            return sections
        }
    }
}
