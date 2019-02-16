//
//  RequestedUserDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct RequestedUserItem {
    let userId: String
    let profileImageURL: String?
    let username: String
    let userDisplayName: String
}

struct RequestedUserSection {
    var items: [Item]
}

extension RequestedUserSection: SectionModelType {
    
    typealias Item = RequestedUserItem
    
    init(original: RequestedUserSection, items: [Item]) {
        self = original
        self.items = items
    }
}
