//
//  Environment.swift
//  AzureCognitive
//
//  Created by Mannie Tagarira on 2/15/18.
//  Copyright © 2018 Microsoft. All rights reserved.
//

internal extension Networking {
    
    internal struct Environment {
        
        internal enum Mode {
            case async, sync
        }
        
        private let mode: Mode
        
        internal init(environment: AzureCognitive.Environment) {
            switch environment {
            case .application   : mode = .async
            case .playground    : mode = .sync
            }
        }
        
        internal func execute(request: Request, completion: AzureCognitive.API.Completion?) {
            let dispatchGroup = DispatchGroup()
            
            switch mode {
            case .async : break
            case .sync  : dispatchGroup.enter()
            }
            
            var response: Response!
            let task = URLSession.shared.dataTask(with: request.urlRequest) { (_data, _response, _error) in
                response = Response(data: _data, response: _response, error: _error)
                
                switch self.mode {
                case .async : completion?(response.status, response.payload)
                case .sync  : dispatchGroup.leave()
                }
            }
            
            task.resume()
            
            switch mode {
            case .async : break
            case .sync  : dispatchGroup.wait(); completion?(response.status, response.payload)
            }
        }
        
    }

    fileprivate struct Response {
        
        fileprivate typealias Status = AzureCognitive.API.Status
        fileprivate typealias Payload = AzureCognitive.API.Payload
        
        fileprivate let status: Status
        fileprivate let payload: Payload
        
        fileprivate init(data: Data?, response: URLResponse?, error: Error?) {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            status = Status(rawValue: statusCode) ?? .unknownError
            
            guard let data = data else {
                payload = .empty
                return
            }
            
            do {
                typealias Object = AzureCognitive.API.Payload.Object
                
                if let json = try JSONSerialization.jsonObject(with: data) as? Object {
                    payload = .object(data: json)
                } else if let json = try JSONSerialization.jsonObject(with: data) as? [Object] {
                    payload = .list(data: json)
                } else {
                    payload = .empty
                }
            } catch {
                payload = .empty
            }
        }
        
    }
    
}
