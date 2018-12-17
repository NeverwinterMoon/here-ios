//
//  ChangeProfileInfoViewController.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/28.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa

final class ChangeProfileInfoViewController: UIViewController, ChangeProfileInfoViewInterface {
    
    var tapSaveProfileInfo: Signal<Void> {
        
        return self.saveProfileInfoButton.rx.tap.asSignal()
    }

    var presenter: ChangeProfileInfoPresenterInterface!

    // MARK: - Private
    private let saveProfileInfoButton = UIButton()
}
