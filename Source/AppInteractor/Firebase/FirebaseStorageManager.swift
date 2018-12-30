//
//  FirebaseStorageUploader.swift
//  AppInteractor
//
//  Created by 服部穣 on 2018/12/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import RxCocoa
import RxSwift

final class FirebaseStorageManager {
    
    public static func uploadFile(_ data: Data, filePath: String, ext: Ext) -> Single<Void> {
        
        return Single.create(subscribe: { observer -> Disposable in
            
            let path = filePath + ext.rawValue
            let fileRef = Storage.storage().reference().child(path)
            fileRef.putData(data, metadata: nil) { (_, error) in
                if let error = error {
                    observer(.error(error))
                    let nserror = error as NSError
                    assertionFailure("\(nserror.code)")
                    return
                }
                observer(.success(()))
            }
            return Disposables.create()
        })
    }
    
    public static func downloadFile() -> Single<Data> {
        
    }
}

public enum Ext: String {
    case jpeg = ".jpg"
    case png = ".png"
}
