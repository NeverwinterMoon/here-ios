//
//  AppTargetType.swift
//  AppRequest
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol AppTargetType: TargetType, PrimitiveSequenceType {
    
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
    
    public var primitiveSequence: PrimitiveSequence<SingleTrait, ElementType> {
        
        return Single.create(subscribe: { (observer) -> Disposable in
            let response = APIProvider.shared.request(TargetTypeWrapper(target: self), completion: { result in
                switch result {
                case let .success(response):
                    do {
                        let data = try response.filterSuccessfulStatusCodes().data
                        observer(.success(data))
                    }
                    catch MoyaError.statusCode {
                        do {
                            let data = response.data
                            //                            TODO: make struct APIError
                            let error = try JSONDecoder().decode(Error.self, from: data)
                            observer(.error(error))
                        }
                        catch {
                            
                        }
                    }
                    catch {
                        
                    }

                case let .failure(error):
                    observer(.error(error))
                }
            })
            
        })
    }
}

extension AppTargetType {
    
    public func asSingle() -> Single<ElementType> {
        
        return self.primitiveSequence
            .asObservable()
            .asSingle()
    }
}

protocol GETTargetType: AppTargetType {}
extension GETTargetType {
    public var method: Moya.Method { return .get }
    public var parameterEncoding: ParameterEncoding { return URLEncoding.default }
}

protocol PUTTargetType: AppTargetType {}
extension PUTTargetType {
    public var method: Moya.Method { return .put }
    public var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
}

protocol POSTTargetType {}
extension POSTTargetType {
    public var method: Moya.Method { return .post }
    public var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
}

protocol PATCHTargetType {}
extension PATCHTargetType {
    public var method: Moya.Method { return .patch }
    public var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
}
