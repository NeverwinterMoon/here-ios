//
//  UserInfoDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct ProfileInfo {
    var emailAddress: String
}

struct ProfileSection {
    var header: String
    var items: [Item]
}

extension ProfileSection: SectionModelType {
    typealias Item = ProfileInfo
    
    init(original: Self, items: [Self.Item]) {
        self = original
        self.items = items
    }
}
