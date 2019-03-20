//
//  ProfileDataSource.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import RxDataSources

struct ProfileItem {
    let icon: UIImage?
    let title: String
    let type: ProfileRowType
}

struct ProfileSection {
    var items: [Item]
}

extension ProfileSection: SectionModelType {
    
    typealias Item = ProfileItem
    
    init(original: ProfileSection, items: [Item]) {
        self = original
        self.items = items
    }
}

enum ProfileRowType {
    case editProfile
    case watchingPlaces
    case friends
    case searchFriends
    case requested
}
