//
//  AppNagivationController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit

public class AppNavigationController: UINavigationController {
    
    public override init(rootViewController: UIViewController) {
        
        super.init(navigationBarClass: UINavigationBar.self, toolbarClass: UIToolbar.self)
        self.pushViewController(rootViewController, animated: false)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
    }
}
