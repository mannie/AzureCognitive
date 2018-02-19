//
//  StringExtensions.swift
//  AzureCognitive
//
//  Created by Mannie Tagarira on 2/16/18.
//  Copyright © 2018 Microsoft. All rights reserved.
//

internal extension String {
        
    internal var sanitizedForQuery: String {
        return trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
}

