//
//  ProfileViewController.swift
//  NowHere
//
//  Created by 服部穣 on 2018/11/16.
//  Copyright © 2018 服部穣. All rights reserved.
//

import UIKit
import AppFoundation
import FlexLayout

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.do {
//            presenter gives this image
            $0.image = UIImage()
            $0.tintColor = .blue
            
//            tmp
            $0.backgroundColor = .blue
        }
        
        self.introTextView.do {
//            presenter gives this image
            $0.text = "testtest"
            $0.font?.withSize(14)
        }
        
        self.friendsLabel.do {
            $0.text = "友達"
            $0.font.withSize(20)
            
            $0.backgroundColor = .red
        }
        
        self.flexLayout()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        self.view.flex.layout()
    }
    
    // MARK: - Private
    private let profileImageView = UIImageView()
    private let introTextView = UITextView()
    private let friendsLabel = UILabel()

    private func flexLayout() {
        
        self.view.flex.define { flex in
            
            flex.addItem().height(150).direction(.row).alignItems(.center).paddingHorizontal(40).marginTop(40).define { flex in
                
                flex.addItem(self.profileImageView).size(80).marginRight(40)
                flex.addItem(self.introTextView).grow(1)
            }
            
            flex.addItem().height(100).define { flex in
                
                flex.addItem(friendsLabel).grow(1).marginLeft(40)
            }
        }
    }
}
