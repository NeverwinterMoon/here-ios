//
//  Date.swift
//  AppExtensions
//
//  Created by 服部穣 on 2018/12/13.
//  Copyright © 2018 服部穣. All rights reserved.
//

import Foundation
import SwiftDate

extension KeyedDecodingContainer {
    
     public func decodeDate(forKey key: KeyedDecodingContainer<K>.Key) throws -> Date {
        
        let dateString = try decode(String.self, forKey: key)
        
        guard let date = date(dateString) else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "date is not fitting the format")
        }
        return date
    }
    
    private func date(_ string: String) -> Date? {
        
        return string.toISODate()?.date
    }
}
