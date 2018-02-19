//
//  API.swift
//  AzureCognitive
//
//  Created by Mannie Tagarira on 2/18/18.
//  Copyright © 2018 Microsoft. All rights reserved.
//

public extension AzureCognitive {
    
    public enum API {
        
        public enum Status: Int {
            case success = 200
            case invalidOrMissingQueryParameter = 400
            case invalidOrMissingSubscriptionKey = 401
            case userNotPermittedToAccessResource = 403
            case httpsUsageRequired = 410
            case exceededQueriesPerSecondQuota = 429
            case unexpectedServerError = 500
            case unknownError = -1
        }
        
        public enum Payload {
            public typealias Object = [String:Any]
            
            case list(data: [Object])
            case object(data: Object)
            case empty
        }
        
        public typealias Completion = (Status, Payload)->Void
        
    }

}
