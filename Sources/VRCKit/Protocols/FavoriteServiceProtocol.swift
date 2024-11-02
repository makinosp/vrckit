//
//  FavoriteServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol FavoriteServiceProtocol: Sendable {
    /// Asynchronously retrieves a list of favorite groups from the server.
    /// - Returns: An array of `FavoriteGroup` objects.
    func listFavoriteGroups() async throws -> [FavoriteGroup]

    /// Lists a user's all favorites with the specified parameters.
    /// - Parameter type: The type of favorite (e.g., friend, world).
    /// - Returns: An array of `Favorite` objects.
    func listFavorites(type: FavoriteType) async throws -> [Favorite]

    /// Lists a user's favorites with the specified parameters.
    /// - Parameters:
    ///   - n: The number of favorites to retrieve. Default is `60`.
    ///   - offset: Offset value of favorites to retrive. Default is `0`.
    ///   - type: The type of favorite (e.g., friend, world).
    ///   - tag: An optional tag to filter favorites.
    /// - Returns: An array of `Favorite` objects.
    func listFavorites(n: Int, offset: Int, type: FavoriteType, tag: String?) async throws -> [Favorite]

    /// Fetches details of favorite groups asynchronously.
    /// - Parameters:
    ///   - favoriteGroups: An array of `FavoriteGroup` objects.
    ///   - type: The type of favorite (e.g., friend, world).
    /// - Returns: An array of `FavoriteList` objects containing detailed information about the favorite groups.
    func fetchFavoriteList(favoriteGroups: [FavoriteGroup], type: FavoriteType) async throws -> [FavoriteList]

    /// Adds a new favorite to a specific group.
    /// - Parameters:
    ///   - type: The type of favorite (e.g., friend, world).
    ///   - favoriteId: The ID of the item to favorite.
    ///   - tag: The tag to associate with the favorite.
    /// - Returns: The newly added `Favorite` object.
    func addFavorite(type: FavoriteType, favoriteId: String, tag: String) async throws -> Favorite

    /// Updates a favorite group with the given parameters, display name, and visibility.
    /// - Parameters:
    ///   - source: An object containing the favorite group's details.
    ///   - displayName: The new display name to update the favorite group with.
    ///   - visibility: The new visibility setting for the favorite group.
    func updateFavoriteGroup(
        source: FavoriteGroup,
        displayName: String,
        visibility: FavoriteGroup.Visibility
    ) async throws

    /// Asynchronously remove favorite.
    /// - Parameter favoriteId: The ID of the favorite to remove.
    /// - Returns: A `SuccessResponse` objects.
    func removeFavorite(favoriteId: String) async throws -> SuccessResponse
}
