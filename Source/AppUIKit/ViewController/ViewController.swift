//
//  ViewController.swift
//  AppUIKit
//
//  Created by 服部穣 on 2018/12/09.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit

extension UIViewController {

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
