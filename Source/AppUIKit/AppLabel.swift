//
//  AppLabel.swift
//  AppUIKit
//
//  Created by 服部穣 on 2019/03/19.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit

final public class AppLabel: UILabel {

    public convenience init() {
        self.init(text: "")
    }
    
    public init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .center
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
