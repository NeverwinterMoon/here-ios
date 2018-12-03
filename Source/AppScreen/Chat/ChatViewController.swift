//
//  ChatViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/16.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit
import FlexLayout

class ChatViewController: UIViewController, ChatViewInterface {
    
    var presenter: ChatPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
}
