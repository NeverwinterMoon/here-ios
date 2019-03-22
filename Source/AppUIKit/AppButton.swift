//
//  AppButton.swift
//  AppUIKit
//
//  Created by 服部穣 on 2018/12/14.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit

final public class AppButton: UIButton {
    
    public convenience init(backgroundColor: UIColor = .blue, title: String = "") {
        self.init(frame: .init(), backgroundColor: backgroundColor, title: title)
    }
    
    public init(frame: CGRect, backgroundColor: UIColor, title: String) {
        
        self.defaultBackgroundColor = backgroundColor
        super.init(frame: frame)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    public override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? self.defaultBackgroundColor : .gray
        }
    }
    
    // MARK: - Private
    private let defaultBackgroundColor: UIColor
}
