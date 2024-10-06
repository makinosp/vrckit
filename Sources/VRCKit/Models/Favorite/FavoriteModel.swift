//
//  FavoriteModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/12.
//

import MemberwiseInit

@MemberwiseInit(.public)
public struct Favorite: Codable, Sendable, Identifiable {
    public let id: String
    public let favoriteId: String
    public let tags: [String]
    public let type: FavoriteType
}

struct RequestToAddFavorite: Codable, Sendable {
    let type: FavoriteType
    let favoriteId: String
    let tags: [String]
}
