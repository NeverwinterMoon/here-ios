//
//  MapCollectionViewCell.swift
//  AppScreen
//
//  Created by 服部穣 on 2019/03/03.
//  Copyright © 2019 服部穣. All rights reserved.
//

import UIKit
import AppInteractor
import AppUIKit
import FlexLayout
import RxSwift

final class MapCollectionViewCell: UICollectionViewCell {
    
    var item: MapItem? {
        didSet {
            guard let item = item else {
                return
            }
            
            self.userDisplayNameLabel.text = item.userDisplayName
            let profileImageURL = (item.profileImageURL != nil) ? "/users/\(item.userId)/profile_image/\(item.profileImageURL!)" : "default.jpg"
            
            FirebaseStorageManager.downloadFile(filePath: profileImageURL)
                .asObservable()
                .filterNil()
                .subscribe(onNext: { [unowned self] in
                    self.profileImageView.image = UIImage(data: $0)
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.flex.layout()
    }

    // MARK: - Private
    private let userDisplayNameLabel = UILabel()
    private let profileImageView = RoundImageView()
    private let disposeBag = DisposeBag()
}
