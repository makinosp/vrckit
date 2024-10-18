//
//  FavoriteServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol FavoriteServiceProtocol: Sendable {
    func listFavoriteGroups() async throws -> [FavoriteGroup]
    func listFavorites(type: FavoriteType) async throws -> [Favorite]
    func fetchFavoriteList(favoriteGroups: [FavoriteGroup], type: FavoriteType) async throws -> [FavoriteList]
    func addFavorite(type: FavoriteType, favoriteId: String, tag: String) async throws -> Favorite
    func updateFavoriteGroup(
        source: FavoriteGroup,
        displayName: String,
        visibility: FavoriteGroup.Visibility
    ) async throws
    func removeFavorite(favoriteId: String) async throws -> SuccessResponse
}
