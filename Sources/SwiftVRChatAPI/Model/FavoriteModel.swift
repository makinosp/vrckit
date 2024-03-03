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

public struct Favorite: Codable {

    public let success: Response?
    public let error: Response?

    public let id: String?
    public let type: FavoriteType?
    public let favoriteId: String?
    public let tags: [String]?
}
