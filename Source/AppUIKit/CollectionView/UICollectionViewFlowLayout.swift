//
//  UICollectionViewFlowLayout.swift
//  AppUIKit
//
//  Created by 服部穣 on 2018/12/17.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit

final public class AppCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public var cellHeight: CGFloat {
        
        didSet {
            
            self.itemSize.height = self.cellHeight
        }
    }
    
    public var cellWidth: CGFloat {
        
        didSet {
            self.itemSize.width = self.cellWidth
        }
    }
    
    public override init() {
        
        self.cellHeight = 0
        self.cellWidth = 0
        
        super.init()
        
        self.minimumLineSpacing = 0
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
