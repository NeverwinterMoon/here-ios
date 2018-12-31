//
//  FriendsListDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/26.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct FriendsListItem {
    let iconFilePath: String?
    let userDisplayName: String
    let username: String
}

struct FriendsListSection {
    
    var items: [Item]
}

extension FriendsListSection: SectionModelType {
    
    typealias Item = FriendsListItem
    
    init(original: FriendsListSection, items: [Item]) {
        self = original
        self.items = items
    }
}
