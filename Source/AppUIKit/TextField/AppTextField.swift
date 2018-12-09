//
//  AppTextField.swift
//  AppUIKit
//
//  Created by 服部穣 on 2018/12/09.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit

public class AppTextField: UITextField {

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.paddingInsets)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.paddingInsets)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.paddingInsets)
    }
    
    // MARK: - Private
    private let paddingInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
}
