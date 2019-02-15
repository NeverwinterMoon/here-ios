//
//  ChatRoomListCollectionViewCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/02/15.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit
import AppExtensions
import AppInteractor
import AppUIKit
import RxCocoa
import RxSwift

final class ChatRoomListCollectionViewCell: UICollectionViewCell {
    
    var item: ChatRoomListItem? {
        didSet {
            guard let item = item else {
                return
            }
            self.usernameLabel.text = item.username
            self.userDisplayNameLabel.text = "@\(item.userDisplayName)"
            
            let profileImageURL: String
            if let url = item.profileImageURL {
                profileImageURL = "/users/\(item.userId)/profile_image/\(url)"
            } else {
                profileImageURL = "default.jpg"
            }
            
            FirebaseStorageManager.downloadFile(filePath: profileImageURL)
                .asObservable()
                .filterNil()
                .subscribe(onNext: {
                    self.profileImageView.image = UIImage(data: $0)
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.usernameLabel.do {
            $0.textAlignment = .center
        }
        
        self.userDisplayNameLabel.do {
            $0.textAlignment = .center
        }
        
        self.contentView.flex.define { flex in
            flex.addItem(self.profileImageView)
            flex.addItem(self.userDisplayNameLabel)
            flex.addItem(self.usernameLabel)
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.flex.layout()
    }

    // MARK: - Private
    private let profileImageView = RoundImageView()
    private let userDisplayNameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let disposeBag = DisposeBag()
}
