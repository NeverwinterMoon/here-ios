//
//  FriendsListCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2018/12/26.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppInteractor
import AppUIKit
import FlexLayout
import RxCocoa
import RxSwift
import RxOptional

final class FriendsListCell: UICollectionViewCell {
    
    var item: FriendsListItem? {
        didSet {
            guard let item = item else {
                return
            }
            self.userDisplayLabel.text = item.userDisplayName
            self.usernameLabel.text = "@\(item.username)"
            
            let filePath: String
            if let url = item.profileImageURL {
                filePath = "/users/\(item.userId)/profile_image/\(url).jpg"
            } else {
                filePath = "dafault.jpg"
            }
            
            FirebaseStorageManager.downloadFile(filePath: filePath)
                .asObservable()
                .filterNil()
                .subscribe(onNext: { [unowned self] in
                    self.profileImageView.image = UIImage(data: $0)
                })
                .disposed(by: self.disposeBag)
        }
    }

    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        self.contentView.flex.direction(.row).paddingHorizontal(20).define { flex in
            
            let contentSize: CGFloat = 70
            
            flex.addItem(self.profileImageView).alignSelf(.center).size(contentSize)
            
            flex.addItem().height(contentSize).paddingLeft(20).justifyContent(.center).alignSelf(.center).grow(1).define { flex in
                flex.addItem(self.userDisplayLabel).grow(1)
                flex.addItem(self.usernameLabel).grow(1)
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
    private let userDisplayLabel = UILabel()
    private let usernameLabel = UILabel()
    private let profileImageView = RoundImageView()
    private let disposeBag = DisposeBag()
}
