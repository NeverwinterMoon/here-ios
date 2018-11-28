//
//  EditUserInfoDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct ProfileInfoItem {
    let title: String
    let body: String
}

struct ProfileInfoSection {
    var header: String
    var items: [Item]
}

extension ProfileInfoSection: SectionModelType {
    typealias Item = ProfileInfoItem

    init(original: ProfileInfoSection, items: [Item]) {
        self = original
        self.items = items
    }
}
