//
//  HomeServices.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import Foundation

class SearchServices: NSObject {
    
    class func searchAPI(keyword: String, success: @escaping SuccessCompletion<SearchResponse>, failure: @escaping FailureCompletion) {
        
        ScalioProvider.shared.requestAPI(.search(keyword: keyword), success: { response in
            success(response)
        }) { error in
            failure(error)
        }
    }
}
