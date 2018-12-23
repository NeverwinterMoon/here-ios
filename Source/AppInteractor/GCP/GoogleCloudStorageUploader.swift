//
//  GoogleCloudStorageUploader.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import Firebase

final public class GoogleCloudStorageUploader {
    
    static let storage = Storage.storage()
    static let storageRef = storage.reference()
    
    public func uploadFile(_ data: Data, filePath: String) {
        
        GoogleCloudStorageUploader.storageRef.child(filePath).putData(data, metadata: nil, completion: nil)
    }
}
