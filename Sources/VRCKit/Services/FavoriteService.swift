//
//  FavoriteService.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public final actor FavoriteService: APIService, FavoriteServiceProtocol {
    public let client: APIClient
    private let limit = 100
    private let maxCount = 400

    /// Asynchronously retrieves a list of favorite groups from the server.
    /// - Returns: An array of `FavoriteGroup` objects.
    public func listFavoriteGroups() async throws -> [FavoriteGroup] {
        let path = "favorite/groups"
        let response = try await client.request(path: path, method: .get)
        return try await Serializer.shared.decode(response.data)
    }

    /// Lists a user's all favorites with the specified parameters.
    /// - Parameter type: The type of favorite (e.g., friend, world).
    /// - Returns: An array of `Favorite` objects.
    public func listFavorites(type: FavoriteType) async throws -> [Favorite] {
        try await withThrowingTaskGroup(of: [Favorite].self) { taskGroup in
            for offset in stride(from: .zero, to: maxCount, by: limit) {
                taskGroup.addTask { [weak self] in
                    guard let self = self else { return [] }
                    return try await listFavorites(n: limit, offset: offset, type: type)
                }
            }
            var results: [Favorite] = []
            for try await favorites in taskGroup {
                results.append(contentsOf: favorites)
            }
            return results
        }
    }

    /// Lists a user's favorites with the specified parameters.
    /// - Parameters:
    ///   - n: The number of favorites to retrieve. Default is `60``.
    ///   - type: The type of favorite (e.g., friend, world).
    ///   - tag: An optional tag to filter favorites.
    /// - Returns: An array of `Favorite` objects.
    private func listFavorites(
        n: Int = 100,
        offset: Int = 0,
        type: FavoriteType,
        tag: String? = nil
    ) async throws -> [Favorite] {
        let path = "favorites"
        var queryItems = [
            URLQueryItem(name: "n", value: n.description),
            URLQueryItem(name: "offset", value: offset.description),
            URLQueryItem(name: "type", value: type.rawValue)
        ]
        if let tag = tag {
            queryItems.append(URLQueryItem(name: "tag", value: tag.description))
        }
        let response = try await client.request(path: path, method: .get, queryItems: queryItems)
        return try await Serializer.shared.decode(response.data)
    }

    /// Fetches details of favorite groups asynchronously.
    /// - Parameters:
    ///   - favoriteGroups: An array of `FavoriteGroup` objects.
    ///   - type: The type of favorite (e.g., friend, world).
    /// - Returns: An array of `FavoriteDetail` objects containing detailed information about the favorite groups.
    public func fetchFavoriteList(favoriteGroups: [FavoriteGroup], type: FavoriteType) async throws -> [FavoriteList] {
        try await withThrowingTaskGroup(of: FavoriteList.self) { taskGroup in
            for favoriteGroup in favoriteGroups.filter({ $0.type == type }) {
                taskGroup.addTask { [weak self] in
                    guard let self = self else { return FavoriteList(id: favoriteGroup.id) }
                    let favorites = try await listFavorites(type: type, tag: favoriteGroup.name)
                    return FavoriteList(id: favoriteGroup.id, favorites: favorites)
                }
            }
            var results: [FavoriteList] = []
            for try await favoriteGroupDetail in taskGroup {
                results.append(favoriteGroupDetail)
            }
            return results
        }
    }

    /// Adds a new favorite to a specific group.
    /// - Parameters:
    ///   - type: The type of favorite (e.g., friend, world).
    ///   - favoriteId: The ID of the item to favorite.
    ///   - tag: The tag to associate with the favorite.
    /// - Returns: The newly added `Favorite` object.
    public func addFavorite(
        type: FavoriteType,
        favoriteId: String,
        tag: String
    ) async throws -> Favorite {
        let path = "favorites"
        let requestData = try await Serializer.shared.encode(
            RequestToAddFavorite(type: type, favoriteId: favoriteId, tags: [tag])
        )
        let response = try await client.request(path: path, method: .post, body: requestData)
        return try await Serializer.shared.decode(response.data)
    }

    /// Updates a favorite group with the given parameters, display name, and visibility.
    /// - Parameters:
    ///   - params: A tuple containing the favorite group's details:
    ///     - type: The type of the favorite group, defined by `FavoriteType`.
    ///     - name: The name of the favorite group.
    ///     - userId: The ID of the user associated with the favorite group.
    ///   - displayName: The new display name to update the favorite group with.
    ///   - visibility: The new visibility setting for the favorite group.
    public func updateFavoriteGroup(
        source: FavoriteGroup,
        displayName: String,
        visibility: FavoriteGroup.Visibility
    ) async throws {
        let pathParams = ["favorite", "group", source.type.rawValue, source.name, source.ownerId]
        let path = pathParams.joined(separator: "/")
        let body = RequestToUpdateFavoriteGroup(displayName: displayName, visibility: visibility)
        let requestData = try await Serializer.shared.encode(body)
        _ = try await client.request(path: path, method: .put, body: requestData)
    }

    /// Asynchronously remove favorite.
    /// - Parameter favoriteId: The ID of the favorite to remove.
    /// - Returns: A `SuccessResponse` objects.
    public func removeFavorite(favoriteId: String) async throws -> SuccessResponse {
        let path = "favorites/\(favoriteId)"
        let response = try await client.request(path: path, method: .delete)
        return try await Serializer.shared.decode(response.data)
    }
}
