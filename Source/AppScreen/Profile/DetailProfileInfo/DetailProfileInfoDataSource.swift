//
//  DetailProfileInfoDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct DetailProfileInfoItem {
    let type: userInfoType
    let body: String?
    let bodyTextColor: UIColor = .black
}

struct EditProfileInfoSection {
    var header: String
    var items: [Item]
}

extension EditProfileInfoSection: SectionModelType {
    typealias Item = DetailProfileInfoItem

    init(original: EditProfileInfoSection, items: [Item]) {
        self = original
        self.items = items
    }
}

struct userInfoType {
    
    let displayTitle: String
    let paramsKey: String
    
    enum InfoType {
        case username
        case userDisplayName
        case selfIntroduction
        case email
    }
    
    let type: InfoType
    
    init(type: InfoType) {
        self.type = type
        switch self.type {
        case .username:
            self.displayTitle = "ユーザー名"
            self.paramsKey = "username"
        case .userDisplayName:
            self.displayTitle = "名前"
            self.paramsKey = "user_display_name"
        case .email:
            self.displayTitle = "メールアドレス"
            self.paramsKey = "email"
        case .selfIntroduction:
            self.displayTitle = "自己紹介"
            self.paramsKey = "self_introduction"
        }
    }
}
