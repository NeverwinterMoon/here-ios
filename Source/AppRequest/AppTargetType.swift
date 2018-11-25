//
//  AppTargetType.swift
//  AppRequest
//
//  Created by 服部穣 on 2018/11/22.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import AppEntity
import Moya
import RxSwift

public protocol AppTargetType: TargetType, PrimitiveSequenceType {
    
    var path: String { get }
    var method: Moya.Method { get }
    var parameters: [String: Any] { get }
    var parameterEncoding: ParameterEncoding { get }
    static func decodeData(_ data: Data) throws -> ElementType
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
            let cancellable = APIProvider.shared.request(TargetTypeWrapper(target: self), completion: { result in
                switch result {
                case let .success(response):
                    do {
                        let data = try response.filterSuccessfulStatusCodes().data
                        let element = try Self.decodeData(data)
                        observer(.success(element))
                    }
                    catch MoyaError.statusCode {
                        do {
                            let data = response.data
                            let error = try JSONDecoder().decode(APIError.self, from: data)
                            observer(.error(error))
                        }
                        catch {
                            assertionFailure("error when decoding Error to APIError: \(error)")
                            observer(.error(error))
                        }
                    }
                    catch {
                        assertionFailure("error when decoding error to data: \(error)")
                        observer(.error(error))
                    }

                case let .failure(error):
                    observer(.error(APIError(moyaError: error)))
                }
            })
            
            return Disposables.create(with: {
                cancellable.cancel()
            })
        })
    }
}

extension AppTargetType where ElementType == Void {
    
    public static func decodeData(_ data: Data) throws {
        
        return
    }
}

extension AppTargetType where ElementType: Decodable {
    
    public static func decodeData(_ data: Data) throws -> ElementType {
        
        return try JSONDecoder().decode(ElementType.self, from: data)
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
