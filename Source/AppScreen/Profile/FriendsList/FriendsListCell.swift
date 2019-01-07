//
//  FriendsListCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/26.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import FlexLayout

final class FriendsListCell: UICollectionViewCell {
    
    var item: FriendsListItem? {
        didSet {
            guard let item = item else {
                return
            }
            self.userDisplayLabel.text = item.userDisplayName
            self.usernameLabel.text = item.username
//            self.profileImageView.image = item.iconFilePath
        }
    }

    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        self.contentView.flex.direction(.row).define { flex in
            
            flex.addItem(self.profileImageView)
            flex.addItem().direction(.column).define { flex in
                flex.addItem(self.userDisplayLabel)
                flex.addItem(self.usernameLabel)
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
    private let profileImageView = UIImageView()
    private let userDisplayLabel = UILabel()
    private let usernameLabel = UILabel()
}
