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
    let title: String
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
