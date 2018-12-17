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
    
    public convenience init(backgroundColor: UIColor = .blue) {
        self.init(frame: .init(), backgroundColor: backgroundColor)
    }
    
    public init(frame: CGRect, backgroundColor: UIColor) {
        
        self.defaultBackgroundColor = backgroundColor
        super.init(frame: frame)
        
        setTitleColor(.white, for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    public override var isEnabled: Bool {
        didSet {
            self.backgroundColor = isEnabled ? self.defaultBackgroundColor : .gray
        }
    }
    
    // MARK: - Private
    private let defaultBackgroundColor: UIColor
}
