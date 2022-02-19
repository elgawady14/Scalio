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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Status.self, forKey: .status)
        desc = try container.decode(String.self, forKey: .desc)
    }
    
    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case desc = "Desc"
    }
}

extension ScalioError {
    init(status: Status, desc: String) {
        self.status = status
        self.desc = desc
    }
}

enum Status: Int, Codable {
    case Error = 1
}
