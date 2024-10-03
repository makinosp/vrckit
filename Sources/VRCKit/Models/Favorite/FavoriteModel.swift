//
//  FavoriteModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/12.
//

import Foundation
import MemberwiseInit

public enum FavoriteType: String, Codable, Sendable {
    case world, avatar, friend
}

@MemberwiseInit(.public)
public struct Favorite: Codable, Sendable, Identifiable {
    public let id: String
    public let favoriteId: String
    public let tags: [String]
    public let type: FavoriteType
}

public struct FavoriteDetail: Sendable, Identifiable {
    public let id: String
    public let favorites: [Favorite]

    public func allFavoritesAre(_ type: FavoriteType) -> Bool {
        favorites.allSatisfy { $0.type == type }
    }
}

@MemberwiseInit(.public)
public struct FavoriteGroup: Codable, Sendable, Identifiable, Hashable {
    public let id: String
    public let displayName: String
    public let name: String
    public let tags: [String]
    public let type: FavoriteType
    public let visibility: Visibility

    public enum Visibility: String, Codable, Sendable {
        case `private`, friends, `public`
    }
}

struct RequestToAddFavorite: Codable, Sendable {
    let type: FavoriteType
    let favoriteId: String
    let tags: [String]
}

struct RequestToUpdateFavoriteGroup: Codable, Sendable {
    let displayName: String?
    let visibility: FavoriteGroup.Visibility?
    let tags: [String]
}
