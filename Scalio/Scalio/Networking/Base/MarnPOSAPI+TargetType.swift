//
//  MarnPOSAPI+TargetType.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import Foundation

extension ScalioAPI: TargetType {
    
    // Base URL will be used to hit the API.
    
    var baseURL: URLRequest? {
        
        var urlStr = NetworkConstants.APP_API_URL + path
        guard ScalioProvider.shared.getConnectionType() == .real else {
            var thepath = path
            checkPostmanURI(&thepath)
            urlStr = NetworkConstants.MOCK_APP_API_URL + thepath
            urlStr += testCaseIdentifier
            return URLRequest(url: URL(string: urlStr)!)
        }
        guard let url = URL(string: urlStr) else { return nil }
        return URLRequest(url: url)
    }
    
    // determine resource path for each endpoint
    // in `MarnPOSAPI` enum with Base Url.
    var path: String {
        switch self {
        case let .search(_, page, perPage):
            return "search/users?q=\(percentEncoding!)&page=\(page)&perPage=\(perPage)"
        }
    }
    
    // HTTP method "GET, POST, PUT ... etc".
    var method: MarnPOSHTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    // header configuration.
    var headers: [String: Any]? { return [:] }
    
    var timeoutInterval: TimeInterval {
        guard !isDebugMode() else {
            // for testing purposes
            guard ScalioProvider.shared.getConnectionType() == .real else {
                return 10
            }
            return 60
        }
        return 15.0
    }
    
    // send parameters with endpoint in body "depend on the service".
    var parameters: Data? { return nil }
    
    // Get a percent encoding string version (replacing spaces with %20).
    var percentEncoding: String? {
        switch self {
        case let .search(keyword, _, _):
            return keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        }
    }
    // specify parameters encoding for each endpoint or service.
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return .URLEncoding
        default:
            return .JSONEncoding
        }
    }
    
    /// Test Case Identifier used in `Postman` mocking server.
    var testCaseIdentifier: String {
        var identifier = ""
        switch self {
        case .search:
            identifier = "1"
        }
        let separator = "/"
        return separator + identifier
    }
}

extension ScalioAPI {
    
    /// `Postman` does not accept `-` passed in URI.
    fileprivate func checkPostmanURI(_ urlStr: inout String) {
        urlStr = urlStr.replacingOccurrences(of: "-", with: "/")
    }
}
