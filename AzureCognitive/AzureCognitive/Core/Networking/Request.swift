//
//  Request.swift
//  AzureCognitive
//
//  Created by Mannie Tagarira on 2/15/18.
//  Copyright © 2018 Microsoft. All rights reserved.
//

internal extension Networking {
    
    internal struct Request {
        
        internal let urlRequest: URLRequest
        
        internal typealias ServiceInfo = AzureCognitive.ServiceInfo
        
        internal enum Method: String {
            case get, post
            
            internal var stringValue: String {
                return rawValue.uppercased()
            }
        }
        
        internal init?(method: Method=Method.get, path: String, info: ServiceInfo, body: String?=nil, payload: AzureCognitive.API.Payload?=nil) {
            guard let base = URL(string: "https://\(info.host)"), let url = URL(string: path, relativeTo: base) else {
                return nil
            }

            var request = URLRequest(url: url, cachePolicy: info.cachePolicy)
            request.httpMethod = method.stringValue
            request[.subscriptionKey] = info.key
            request[.userAgent] = UserAgent.shared.info
            
            switch method {
            case .post where body != nil:
                request[.contentType] = "application/x-www-form-urlencoded"
                request.httpBody = body?.data(using: .utf8)
            case .post where payload != nil:
                request[.contentType] = "application/json"
                request.httpBody = try? JSONSerialization.data(withJSONObject: payload ?? [:], options: .prettyPrinted)
            case .post: return nil
            case .get: break
            }
            
            urlRequest = request
        }
        
    }
    
    fileprivate struct UserAgent {
        
        fileprivate static let shared = UserAgent()

        fileprivate let info: String
        
        fileprivate init() {
            let bundle = Bundle.main.infoDictionary
            guard let name = bundle?["CFBundleName"] as? String, let version = bundle?["CFBundleShortVersionString"] as? String else {
                fatalError("Failed to load bundle info")
            }
            
            let device = UIDevice.current
            info = "\(device.name)— \(name), \(version) (\(device.systemName) \(device.systemVersion))"
        }
    
    }

}

fileprivate extension URLRequest {
    
    fileprivate enum HeaderField: String {
        case contentType = "Content-Type"
        case subscriptionKey = "Ocp-Apim-Subscription-Key"
        case userAgent = "User-Agent"
    }

    fileprivate subscript(field: HeaderField) -> String? {
        get {
            return value(forHTTPHeaderField: field.rawValue)
        }
        set {
            setValue(newValue, forHTTPHeaderField: field.rawValue)
        }
    }

}
