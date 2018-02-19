//
//  AutoSuggest.swift
//  AzureCognitive
//
//  Created by Mannie Tagarira on 2/15/18.
//  Copyright © 2018 Microsoft. All rights reserved.
//

import Foundation

// https://docs.microsoft.com/en-us/azure/cognitive-services/Bing-Autosuggest

public enum Search {

    public struct AutoSuggest {
        
        private let info: AzureCognitive.ServiceInfo
        private let environment: Networking.Environment
        
        public init(info: AzureCognitive.ServiceInfo, environment: AzureCognitive.Environment=AzureCognitive.environment) {
            self.info = info
            self.environment = Networking.Environment(environment: environment)
        }
        
        public func suggest(query: String, completion: AzureCognitive.API.Completion?) {
            let path = "/bing/v7.0/suggestions?q=\(query.sanitizedForQuery)"
            
            guard let request = Networking.Request(path: path, info: info) else {
                return
            }
            
            environment.execute(request: request) { (status, payload) in
                completion?(status, payload)
            }
        }
        
    }
    
}
