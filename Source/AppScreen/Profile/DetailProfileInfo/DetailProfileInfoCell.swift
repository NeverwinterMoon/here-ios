//
//  DetailProfileInfoCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/11/23.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class DetailProfileInfoCell: UICollectionViewCell {
    
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
            
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.numberOfLines = 1
//            $0.addGestureRecognizer(self.bodyLabelTouchRecognizer)
            $0.textAlignment = .center
        }

        self.bodyLabel.do {

            $0.font = UIFont.systemFont(ofSize: 20)
            $0.numberOfLines = 0
            $0.preferredMaxLayoutWidth = self.contentView.bounds.width - 150
//            $0.addGestureRecognizer(self.bodyLabelTouchRecognizer)
        }

        self.contentView.flex.direction(.row).alignItems(.center).define { flex in

            flex.addItem(self.titleLabel).width(100).marginHorizontal(30)
            flex.addItem(self.bodyLabel).grow(1)
        }
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.contentView.flex.layout()
    }

    // MARK: - Private
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let bodyLabelTouchRecognizer = UITapGestureRecognizer()
}
