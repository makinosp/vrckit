//
//  FavoriteList.swift
//  VRCKit
//
//  Created by makinosp on 2024/10/06.
//

public struct FavoriteList: Sendable, Identifiable {
    public let id: String
    public let favorites: [Favorite]
}

public extension FavoriteList {
    init(id: ID) {
        self.init(id: id, favorites: [])
    }
}

public extension FavoriteList {
    func allFavoritesAre(_ type: FavoriteType) -> Bool {
        favorites.allSatisfy { $0.type == type }
    }
}
