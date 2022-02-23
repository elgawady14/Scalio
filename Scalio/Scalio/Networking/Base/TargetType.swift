//
//  TargetType.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import Foundation

/// The protocol used to define teh specifications nessary for `ScalioProvider`.
protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: URLRequest? { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: ScalioHTTPMethod { get }

    /// The parameters to be used.
    var parameters: Data? { get }
        
    /// The headers to be used.
    var headers: [String: Any]? { get }
    
    /// Test Case Identifier used in `Postman` mocking server.
    var testCaseIdentifier: String { get }
}

enum ScalioHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum ParameterEncoding: String {
    case JSONEncoding = "JSONEncoding"
    case URLEncoding = "URLEncoding"
}
