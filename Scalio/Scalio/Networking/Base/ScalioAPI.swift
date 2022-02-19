//
//  MarnPOSAPI.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import Foundation

// Here's all Scalio APIs
enum ScalioAPI {
    case search(keyword: String)
}

extension ScalioAPI {
    
    static func !=(lhs: ScalioAPI, rhs: ScalioAPI) -> Bool {
        return lhs.path != rhs.path
    }
    
    static func ==(lhs: ScalioAPI, rhs: ScalioAPI) -> Bool {
        return lhs.path == rhs.path
    }
    
    func isDebugMode() -> Bool {
        guard let mode = Bundle.main.object(forInfoDictionaryKey: "MODE") as? String, mode == "DEBUG" else { return false }
        return true
    }
}

