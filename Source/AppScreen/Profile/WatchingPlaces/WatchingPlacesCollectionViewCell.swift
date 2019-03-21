//
//  WatchingPlacesCollectionViewCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/20.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit
import AppUIKit
import FlexLayout

final class WatchingPlacesCollectionViewCell: UICollectionViewCell {
    
    var item: WatchingPlacesItem? {
        didSet {
            guard let item = item else {
                return
            }
            self.titleLabel.text = item.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.flex.define { flex in
            flex.addItem(self.titleLabel)
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.contentView.flex.layout()
    }
    
    // MARK: - Private
    private let titleLabel = AppLabel()
}
