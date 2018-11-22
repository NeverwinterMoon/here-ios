//
//  AppTargetType.swift
//  AppRequest
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import Moya

protocol AppTargetType: TargetType {
    
    var path: String { get }
    var method: Moya.Method { get }
    var parameters: [String: Any] { get }
    var parameterEncoding: ParameterEncoding { get }
}

extension AppTargetType {
    
    public var baseURL: URL {
        
        #if STAGE
            return URL(string: "STAGING_URL")!
        #else
            return URL(string: "PRODUCTION_URL")!
        #endif
    }
    
    public var sampleData: Data {
        
        return Data()
    }
    
    public var task: Moya.Task {
        
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
    
    public var headers: [String : String]? {
        
        return nil
    }
}
