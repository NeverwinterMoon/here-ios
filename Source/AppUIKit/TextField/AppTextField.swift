//
//  AppTextField.swift
//  AppUIKit
//
//  Created by 服部穣 on 2018/12/09.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit
import AppExtensions
import RxCocoa
import RxSwift

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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.do {
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.cornerRadius = 10
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
        }
    }
    
    public var isNotEmpty: Observable<Bool> {
        return self.rx.text.map {
            guard let text = $0 else {
                return false
            }
            return !text.trimmingCharacters(in: .whitespaces).isEmpty
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - Private
    private let paddingInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
}
