//
//  Message.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/25.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: Sender
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
