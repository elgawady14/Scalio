//
//  ScalioError.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import Foundation

struct ScalioError: Decodable {
    let status: Status
    let desc: String
    init(status: Status, desc: String) {
        self.status = status
        self.desc = desc
    }

    
    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case desc = "Desc"
    }
}

enum Status: Int, Codable {
    case Error = 1
}
