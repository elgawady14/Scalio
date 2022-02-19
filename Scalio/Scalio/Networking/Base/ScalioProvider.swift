//
//  ScalioProvider.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import Foundation

typealias RequestClosure<T: Decodable> = (target: ScalioAPI, success: SuccessCompletion<T>, failure: FailureCompletion)
typealias SuccessCompletion<T: Decodable> = (T) -> Void
typealias FailureCompletion = (ScalioError?) -> Void

class ScalioProvider: NSObject {
    
    static var shared = ScalioProvider()
    fileprivate var connection = ScalioConnection.real
    
    // MARK:- Public
    func requestAPI<T: Decodable>(_ target: ScalioAPI, success: @escaping SuccessCompletion<T>, failure: @escaping FailureCompletion) {
        requestAPI((target: target, success: success, failure: failure))
    }
    
    fileprivate func requestAPI<T: Decodable>(_ request: RequestClosure<T>) {

        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.timeoutIntervalForRequest = request.target.timeoutInterval
        configuration.httpAdditionalHeaders = filterHttpHeaders(request.target.headers)
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: .current)
        guard let theUrlRequest = request.target.baseURL else { return }
        var urlRequest = theUrlRequest
        urlRequest.httpMethod = request.target.method.rawValue
        urlRequest.timeoutInterval = request.target.timeoutInterval
        urlRequest.httpBody = request.target.parameters
        debugPrint("API REQUEST: \(urlRequest)")
        requestTask(urlRequest, session, request)
    }
    
    fileprivate func requestTask<T>(_ urlRequest: URLRequest, _ session: URLSession, _ request: RequestClosure<T>) {
        
        let task = session.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, !data.isEmpty, let statusCode = (response as? HTTPURLResponse)?.statusCode, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
                // request timeout
                DispatchQueue.main.async { self?.handleRequest(request, nil, nil, nil) }
                return
            }
            debugPrint("API RESPONSE: \(json)")
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { self?.handleRequest(request, response, nil, statusCode) }
            } catch(let decoderError) {
                debugPrint(decoderError)
                let error = ScalioError(status: .Error, desc: "Modeling Error.")
                DispatchQueue.main.async { self?.handleRequest(request, nil, error, 0) }
            }
        }
        task.resume()
    }
}

// MARK:- `requestAPI` handler
extension ScalioProvider {
    
    fileprivate func handleRequest<T>(_ request: RequestClosure<T>, _ response: T?, _ error: ScalioError? = nil, _ statusCode: Int?) {
        
        guard let response = response else {
            guard let error = error else {
                request.failure(ScalioError(status: .Error, desc: NSLocalizedString("TimeoutConnection", comment: "")))  // request timeout
                return
            }
            request.failure(error)
            return
        }
        request.success(response)
    }
}

extension ScalioProvider {
    
    /// Used to differentiate between real & mocking
    /// backend endpoints used in unit testing
    enum ScalioConnection {
        case real
        case mock
    }
    
    func setConnection(_ type: ScalioConnection) {
        self.connection = type
    }
    
    func getConnectionType() -> ScalioConnection {
        return self.connection
    }
    
    fileprivate func filterHttpHeaders(_ headers: [String:Any]?) -> [String:Any]? {
        /// For unit testing only send `POSTMAN_API_KEY` http header key-value.
        return headers?.filter { connection == .real || (connection == .mock && $0.key == TestConstants.POSTMAN_API_KEY) }
    }
}
