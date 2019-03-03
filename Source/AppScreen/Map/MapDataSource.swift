//
//  MapDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct MapItem {
    let userId: String
    let profileImageURL: String?
    let userDisplayName: String
    let username: String
}

struct MapSection {
    var items: [Item]
}

extension MapSection: SectionModelType {
    
    typealias Item = MapItem
    
    init(original: MapSection, items: [Item]) {
        self = original
        self.items = items
    }
}
