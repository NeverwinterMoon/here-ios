//
//  RequestedUserCollectionViewCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit
import AppExtensions
import AppInteractor
import AppUIKit
import FlexLayout
import RxCocoa
import RxSwift

class RequestedUserCollectionViewCell: UICollectionViewCell {
    
    var item: RequestedUserItem? {
        didSet {
            guard let item = item else {
                return
            }
            self.userDisplayName.text = item.userDisplayName
            self.usernameLabel.text = "@\(item.username)"
            
            let profileImageURL: String
            if let url = item.profileImageURL {
                profileImageURL = "/users/\(item.userId)/profile_image/\(url).jpg"
            } else {
                profileImageURL = "default.jpg"
            }
            FirebaseStorageManager.downloadFile(filePath: profileImageURL)
                .asObservable()
                .filterNil()
                .subscribe(onNext: { [unowned self] in
                    self.profileImageView.image = UIImage(data: $0)
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.approveButton.do {
            $0.setTitle("承認", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = 10
        }
        
        self.declineButton.do {
            $0.setTitle("拒否", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
        }
        
        self.userDisplayName.do {
            $0.textAlignment = .center
        }
        
        self.usernameLabel.do {
            $0.textAlignment = .center
            $0.textColor = .gray
        }

        self.contentView.flex.direction(.row).define { flex in
            
            flex.addItem(self.profileImageView).size(70).alignSelf(.center).margin(10)
            
            flex.addItem().grow(1).direction(.column).marginRight(20).define { flex in
                
                flex.addItem().direction(.row).alignContent(.center).height(30).marginTop(20).define { flex in
                    flex.addItem(self.userDisplayName).grow(1)
                    flex.addItem(self.usernameLabel).grow(1)
                }
                flex.addItem().direction(.row).alignSelf(.stretch).justifyContent(.center).height(30).marginTop(10).define { flex in
                    flex.addItem(self.approveButton).width(80).marginRight(20)
                    flex.addItem(self.declineButton).width(80)
                }
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.flex.layout()
    }
    
    // MARK: - Private
    private let approveButton = UIButton()
    private let declineButton = UIButton()
    private let profileImageView = RoundImageView()
    private let usernameLabel = UILabel()
    private let userDisplayName = UILabel()
    private let disposeBag = DisposeBag()
}
