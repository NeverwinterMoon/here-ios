//
//  ProfileInfoCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/23.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation

final class ProfileInfoCell: UITableViewCell {
    
    var title: String? {
        
        didSet {
            self.textLabel?.text = title
        }
    }
    
    var content: String? {
        
        didSet {
            self.bodyLabel.text = content
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.bodyLabel.do {
            
            $0.numberOfLines = 1
        }
        
        self.contentView.flex.define { flex in
            
            flex.addItem().direction(.row).paddingHorizontal(30).define { flex in
               
                flex.addItem(self.bodyLabel)
            }
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.contentView.flex.layout()
    }

    // MARK: - Private
    private let bodyLabel = UILabel()
}
