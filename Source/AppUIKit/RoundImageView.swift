//
//  RoundImageView.swift
//  AppUIKit
//
//  Created by 服部穣 on 2018/12/25.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final public class RoundImageView: UIImageView {
    
    public override var frame: CGRect {
        didSet {
            self.layer.cornerRadius = self.frame.width/2
        }
    }

    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.contentMode = .scaleAspectFit
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
