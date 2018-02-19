//
//  ServiceInfo.swift
//  AzureCognitive
//
//  Created by Mannie Tagarira on 2/15/18.
//  Copyright © 2018 Microsoft. All rights reserved.
//

public extension AzureCognitive {
    
    public struct ServiceInfo {
        
        internal let host: String
        internal let key: String
        internal let cachePolicy: URLRequest.CachePolicy
        
        public typealias CachePolicy = URLRequest.CachePolicy
        
        public init(host: String, key: String, cachePolicy: CachePolicy=CachePolicy.useProtocolCachePolicy) {
            self.host = host
            self.key = key
            self.cachePolicy = cachePolicy
        }
        
    }
    
}
