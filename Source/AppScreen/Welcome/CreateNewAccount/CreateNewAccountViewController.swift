//
//  CreateNewAccountViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/04.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa

final class CreateNewAccountViewController: UIViewController, CreateNewAccountViewInterface {
    
    var tapCreateAccount: Signal<Void> {
        
        return self.createAccountButton.rx.tap.asSignal()
    }
    
    override func viewDidLoad() {
        
        self.title = "新しいアカウント"
    }
    
    // MARK: - Private
    private let createAccountButton = UIButton()
}
