//
//  EditUserInfoDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct EditProfileInfoItem {
    let title: String
    let body: String
}

struct EditProfileInfoSection {
    var header: String
    var items: [Item]
}

extension EditProfileInfoSection: SectionModelType {
    typealias Item = EditProfileInfoItem

    init(original: EditProfileInfoSection, items: [Item]) {
        self = original
        self.items = items
    }
}
