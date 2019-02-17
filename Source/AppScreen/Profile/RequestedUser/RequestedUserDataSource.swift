//
//  RequestedUserDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct RequestedUserItem: IdentifiableType, Equatable {
    
    typealias Identity = String
    
    var identity: String {
        return self.userId
    }
    
    let userId: String
    let profileImageURL: String?
    let username: String
    let userDisplayName: String
}

struct RequestedUserSection {
    var items: [Item]
}

extension RequestedUserSection: AnimatableSectionModelType {

    typealias Identity = [String]
    
    var identity: [String] {
        return self.items.map { $0.userId }
    }

    typealias Item = RequestedUserItem
    
    init(original: RequestedUserSection, items: [Item]) {
        self = original
        self.items = items
    }
}
