//
//  SearchFriendsCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation
import FlexLayout

final class SearchFriendsCell: UICollectionViewCell {
    
    var item: SearchFriendsItem? {
        
        didSet {
            guard let item = item else {
                return
            }
            // TODO: iconImage
            self.iconImageView.image = UIImage(named: "first")
            self.displayNameLabel.text = item.displayName
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
        
        self.contentView.flex.direction(.row).define { flex in
            
            flex.addItem(self.iconImageView).size(70).alignSelf(.center)
            flex.addItem(self.displayNameLabel).grow(1)
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    // MARK: - Private
    private let iconImageView = UIImageView()
    private let displayNameLabel = UILabel()
}
