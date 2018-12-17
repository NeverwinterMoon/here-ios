//
//  EditUserInfoPresenter.swift
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

final class EditUserInfoPresenter: EditUserInfoPresenterInterface {
    
    let userEmailAddress: Driver<String?>
    let selfIntroduction: Driver<String?>
    let userProfileImageURL: Driver<URL>
    
    var sections: Driver<[EditProfileInfoSection]> {
        
        return self.sectionsRelay.asDriver()
    }
    
    private let sectionsRelay: BehaviorRelay<[EditProfileInfoSection]> = .init(value: [])

    init(view: EditUserInfoViewInterface, interactor: EditUserInfoInteractorInterface, wireframe: EditUserInfoWireframeInterface) {
        
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        
        let user: Driver<User> = self.interactor.activatedUser().asDriver(onErrorJustReturn: .init()).filterNil()
        
        user.asObservable().mapSections().bind(to: self.sectionsRelay).disposed(by: self.disposeBag)
        self.userEmailAddress = user.map { $0.email }
        self.selfIntroduction = user.map { $0.selfIntroduction }
        self.userProfileImageURL = user.map { URL(string: $0.profileImageURL!) }.filterNil()
        
//        view.tapChangeProfileImage
        view.tapEditProfileRow
            .map { [unowned self] in
                self.sectionsRelay.value[$0.section].items[$0.item]
            }
            .asObservable()
            .subscribe(onNext: { [unowned self] item in
                self.wireframe.pushEditProfileInfo(infoInChange: item.title, currentContent: item.body ?? "")
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Private
    private let view: EditUserInfoViewInterface
    private let interactor: EditUserInfoInteractorInterface
    private let wireframe: EditUserInfoWireframeInterface
    private let disposeBag = DisposeBag()
}

fileprivate extension Observable where E == User {
    
    fileprivate func mapSections() -> Observable<[EditProfileInfoSection]> {
        
        return self.map {
            
            var items: [EditProfileInfoItem] = []
            items.append(EditProfileInfoItem(title: "名前", body: $0.userDisplayName))
            items.append(EditProfileInfoItem(title: "ユーザー名", body: $0.username))
            items.append(EditProfileInfoItem(title: "自己紹介", body: $0.selfIntroduction))
            let sections = [EditProfileInfoSection(header: "プロフィール", items: items)]
            return sections
        }
    }
}
