//
//  APIError.swift
//  AppEntity
//
//  Created by 服部穣 on 2018/11/25.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import Moya

public struct APIError: Error, Decodable {
    
    public enum ErrorType {
        case serverError
        case moyaError(MoyaError)
        case unknown
    }
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message
    }
    
    public let type: ErrorType
    public let errorCode: String
    public let message: String
    
    public init(moyaError: MoyaError) {
        
        self.type = .moyaError(moyaError)
        self.errorCode = "moya_error"
        self.message = "不明なエラーが発生しました"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.errorCode = try container.decode(String.self, forKey: .errorCode)
        self.message = try container.decode(String.self, forKey: .message)
        self.type = .serverError
    }
}
