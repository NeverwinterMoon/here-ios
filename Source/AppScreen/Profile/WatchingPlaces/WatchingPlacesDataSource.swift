//
//  WatchingPlacesDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct WatchingPlacesItem {
    let name: String
}

struct WatchingPlacesSection {
    var items: [Item]
}

extension WatchingPlacesSection: SectionModelType {
    
    typealias Item = WatchingPlacesItem
    
    init(original: WatchingPlacesSection, items: [Item]) {
        self = original
        self.items = items
    }
}
