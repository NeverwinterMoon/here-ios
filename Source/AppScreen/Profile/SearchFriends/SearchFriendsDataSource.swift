//
//  SearchFriendsDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct SearchFriendsItem {
    let icon: String?
    let userId: String
    let displayName: String
    let username: String
    let profileImageURL: String?
}

struct SearchFriendsSection {
    var items: [Item]
}

extension SearchFriendsSection: SectionModelType {
    
    typealias Item = SearchFriendsItem
    
    init(original: SearchFriendsSection, items: [Item]) {
        
        self = original
        self.items = items
    }
}
