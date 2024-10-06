//
//  FavoriteServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol FavoriteServiceProtocol: Sendable {
    typealias FavoriteGroupParams = (type: FavoriteType, name: String, userId: String)
    func listFavoriteGroups() async throws -> [FavoriteGroup]
    func listFavorites(n: Int, type: FavoriteType, tag: String?) async throws -> [Favorite]
    func fetchFavoriteGroupDetails(favoriteGroups: [FavoriteGroup]) async throws -> [FavoriteDetail]
    func addFavorite(type: FavoriteType, favoriteId: String, tag: String) async throws -> Favorite
    func updateFavoriteGroup(
        params: FavoriteGroupParams,
        displayName: String,
        visibility: FavoriteGroup.Visibility
    ) async throws -> SuccessResponse
    func removeFavorite(favoriteId: String) async throws -> SuccessResponse
}
