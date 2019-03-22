//
//  ProfileCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/01/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import Foundation

final class ProfileCollectionViewCell: UICollectionViewCell {
    
    var item: ProfileItem? {
        didSet {
            guard let item = item else {
                return
            }
            self.titleLabel.text = item.title
        }
    }
    
    convenience init() {
        
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.flex.direction(.row).define { flex in
            flex.addItem(self.iconImageView).size(100)
            flex.addItem(self.titleLabel).grow(1)
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.contentView.flex.layout()
    }

    // MARK: - Private
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
}
