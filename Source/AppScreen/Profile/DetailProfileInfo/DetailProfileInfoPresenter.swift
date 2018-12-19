//
//  DetailProfileInfoPresenter.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/20.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import RxCocoa
import RxOptional
import RxSwift

final class DetailProfileInfoPresenter: DetailProfileInfoPresenterInterface {
    
    let userEmailAddress: Driver<String?>
    let selfIntroduction: Driver<String?>
    let userProfileImageURL: Driver<URL>
    
    var sections: Driver<[EditProfileInfoSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[EditProfileInfoSection]> = .init(value: [])

    init(view: DetailProfileInfoViewInterface, interactor: DetailProfileInfoInteractorInterface, wireframe: DetailProfileInfoWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user: Driver<User> = self.interactor.activatedUser().asDriver(onErrorJustReturn: .init()).filterNil()
        
        user.asObservable().mapSections().bind(to: self.sectionsRelay).disposed(by: self.disposeBag)
        self.userEmailAddress = user.map { $0.email }
        self.selfIntroduction = user.map { $0.selfIntroduction }
        self.userProfileImageURL = user.map { URL(string: $0.profileImageURL!) }.filterNil()
        
        view.tapEditProfileRow
            .map { [unowned self] in
                self.sectionsRelay.value[$0.section].items[$0.item]
            }
            .asObservable()
            .subscribe(onNext: { [unowned self] item in
                self.wireframe.pushEditProfileInfo(infoInChange: item.type.paramsKey, currentContent: item.body ?? "")
            })
            .disposed(by: self.disposeBag)
        
//        view.tapChangeProfileImage
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
            
            var items: [DetailProfileInfoItem] = []
            items.append(DetailProfileInfoItem(type: userInfoType(type: .userDisplayName), body: $0.userDisplayName))
            items.append(DetailProfileInfoItem(type: userInfoType(type: .username), body: $0.username))
            items.append(DetailProfileInfoItem(type: userInfoType(type: .selfIntroduction), body: $0.selfIntroduction))
            let sections = [EditProfileInfoSection(header: "プロフィール", items: items)]
            return sections
        }
    }
}
