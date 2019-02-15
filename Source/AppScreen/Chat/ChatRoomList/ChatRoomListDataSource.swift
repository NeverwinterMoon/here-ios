//
//  ChatRoomListDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct ChatRoomListItem {
    let userId: String
    let profileImageURL: String?
    let userDisplayName: String
    let username: String
}

struct ChatRoomListSection {
    var items: [Item]
}

extension ChatRoomListSection: SectionModelType {
    
    typealias Item = ChatRoomListItem
    
    init(original: ChatRoomListSection, items: [Item]) {
        self = original
        self.items = items
    }
}
