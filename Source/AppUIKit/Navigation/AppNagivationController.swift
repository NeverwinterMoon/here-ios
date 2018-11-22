//
//  AppNagivationController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit

open class AppNavigationController: UINavigationController {
    
    public override init(rootViewController: UIViewController) {
        
        super.init(navigationBarClass: UINavigationBar.self, toolbarClass: UIToolbar.self)
        self.pushViewController(rootViewController, animated: false)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
    }
}
