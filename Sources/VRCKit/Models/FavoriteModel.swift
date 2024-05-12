//
//  FavoriteModel.swift
//  
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

public struct FavoriteGroup: Codable, Identifiable {
    public let id: String
    public let displayName: String
    public let name: String
    public let tags: [String]
    public let type: FavoriteType
    public let visibility: String
}

public struct RequestToAddFavorite: Codable {
    public let type: FavoriteType
    public let favoriteId: String
    public let tags: [String]
}
