//
//  FavoriteModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/12.
//

public enum FavoriteType: String, Codable {
    case world
    case avatar
    case friend
}

public struct Favorite: Codable, Identifiable {
    public let id: String
    public let favoriteId: String
    public let tags: [String]
    public let type: FavoriteType
}

public struct FavoriteDetail: Identifiable {
    public let id: String
    public let favorites: [Favorite]

    public func allFavoritesAre(_ type: FavoriteType) -> Bool {
        favorites.allSatisfy { $0.type == type }
    }
}

public struct FavoriteGroup: Codable, Identifiable {
    public let id: String
    public let displayName: String
    public let name: String
    public let tags: [String]
    public let type: FavoriteType
    public let visibility: String
}

struct RequestToAddFavorite: Codable {
    let type: FavoriteType
    let favoriteId: String
    let tags: [String]
}
