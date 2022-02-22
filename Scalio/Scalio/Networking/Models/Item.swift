//
//  Item.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 20/02/2022.
//

import Foundation

struct Item: Codable, Identifiable {
    let id = UUID()
    let login, avatarURL, type: String

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case type = "type"
    }
}

