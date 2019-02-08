//
//  SearchFriendsCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import AppUIKit
import FlexLayout

final class SearchFriendsCell: UICollectionViewCell {
    
    var item: SearchFriendsItem? {
        
        didSet {
            guard let item = item else {
                return
            }
            // TODO: iconImage
            self.iconImageView.image = UIImage(named: "first")
            self.displayNameLabel.do {
                $0.text = item.displayName
                $0.font = .boldSystemFont(ofSize: 20)
            }
            self.usernameLabel.do {
                $0.text = "@\(item.username)"
                $0.font = .systemFont(ofSize: 20)
            }
        }
    }
    
    convenience init() {
        
        self.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.contentView.flex.layout()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.flex.direction(.row).paddingHorizontal(20).define { flex in
            
            let contentSize: CGFloat = 70
            
            flex.addItem(self.iconImageView).alignSelf(.center).size(contentSize)
            
            flex.addItem().height(contentSize).paddingLeft(20).justifyContent(.center).alignSelf(.center).grow(1).define { flex in
                flex.addItem(self.displayNameLabel).grow(1)
                flex.addItem(self.usernameLabel).grow(1)
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - Private
    private let iconImageView = RoundImageView()
    private let displayNameLabel = UILabel()
    private let usernameLabel = UILabel()
}
