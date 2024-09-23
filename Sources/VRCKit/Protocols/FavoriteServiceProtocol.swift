//
//  FavoriteServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol FavoriteServiceProtocol: Sendable {
    func listFavoriteGroups() async throws -> [FavoriteGroup]
    func listFavorites(n: Int, type: FavoriteType, tag: String?) async throws -> [Favorite]
    func fetchFavoriteGroupDetails(favoriteGroups: [FavoriteGroup]) async throws -> [FavoriteDetail]
    func addFavorite(type: FavoriteType, favoriteId: String, tag: String) async throws -> Favorite
    func removeFavorite(favoriteId: String) async throws -> SuccessResponse
}
