//
//  EditProfileInfoCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/23.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class EditProfileInfoCell: UICollectionViewCell {
    
    var title: String? {
        
        didSet {
            self.titleLabel.text = self.title
        }
    }
    
    var content: String? {
        
        didSet {
            self.bodyLabel.text = self.content
        }
    }
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        
        self.titleLabel.do {
            
            $0.numberOfLines = 1
        }

        self.bodyLabel.do {

            $0.numberOfLines = 1
        }
        
        self.contentView.flex.define { flex in

            flex.addItem().direction(.row).marginHorizontal(30).define { flex in

                flex.addItem(self.titleLabel)
                flex.addItem(self.bodyLabel)
            }
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.contentView.flex.layout()
    }

    // MARK: - Private
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
}
