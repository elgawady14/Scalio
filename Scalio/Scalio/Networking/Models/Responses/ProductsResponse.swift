//
//  SearchResponse.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import Foundation

struct SearchResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try container.decode(Int.self, forKey: .totalCount)
        incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
        items = try container.decode([Item].self, forKey: .items)
    }
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}

struct Item: Codable {
    let login, avatarURL, type: String

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case type = "type"
    }
}
