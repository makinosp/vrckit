//
//  FavoriteService.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

public final actor FavoriteService: APIService, FavoriteServiceProtocol {
    public let client: APIClient
    private let path = "favorites"

    // Initializes the AuthenticationService with an APIClient instance
    public init(client: APIClient) {
        self.client = client
    }

    /// Asynchronously retrieves a list of favorite groups from the server.
    /// - Returns: An array of `FavoriteGroup` objects.
    public func listFavoriteGroups() async throws -> [FavoriteGroup] {
        let path = "favorite/groups"
        let response = try await client.request(path: path, method: .get)
        return try await Serializer.shared.decode(response.data)
    }

    /// Lists a user's favorites with the specified parameters.
    /// - Parameters:
    ///   - n: The number of favorites to retrieve. Default is `60``.
    ///   - type: The type of favorite (e.g., friend, world).
    ///   - tag: An optional tag to filter favorites.
    /// - Returns: An array of `Favorite` objects.
    public func listFavorites(
        n: Int = 60,
        type: FavoriteType,
        tag: String? = nil
    ) async throws -> [Favorite] {
        var queryItems = [
            URLQueryItem(name: "n", value: n.description),
            URLQueryItem(name: "type", value: type.rawValue)
        ]
        if let tag = tag {
            queryItems.append(URLQueryItem(name: "tag", value: tag.description))
        }
        let response = try await client.request(path: path, method: .get, queryItems: queryItems)
        return try await Serializer.shared.decode(response.data)
    }

    /// Fetches details of favorite groups asynchronously.
    /// - Parameter favoriteGroups: An array of `FavoriteGroup` objects.
    /// - Returns: An array of `FavoriteDetail` objects containing detailed information about the favorite groups.
    public func fetchFavoriteGroupDetails(
        favoriteGroups: [FavoriteGroup]
    ) async throws -> [FavoriteDetail] {
        var results: [FavoriteDetail] = []
        try await withThrowingTaskGroup(of: FavoriteDetail.self) { taskGroup in
            for favoriteGroup in favoriteGroups.filter({ $0.type == .friend }) {
                taskGroup.addTask { [weak self] in
                    guard let self = self else {
                        throw VRCKitError.unexpected
                    }
                    let favorites = try await self.listFavorites(
                        type: .friend,
                        tag: favoriteGroup.name
                    )
                    return FavoriteDetail(id: favoriteGroup.id, favorites: favorites)
                }
            }
            for try await favoriteGroupDetail in taskGroup {
                results.append(favoriteGroupDetail)
            }
        }
        return results
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
        let requestData = try await Serializer.shared.encode(
            RequestToAddFavorite(type: type, favoriteId: favoriteId, tags: [tag])
        )
        let response = try await client.request(path: path, method: .post, body: requestData)
        return try await Serializer.shared.decode(response.data)
    }

    public func updateFavoriteGroup(
        type: FavoriteType,
        favoriteGroupName: String,
        userId: String
    ) async throws {
        let requestData = RequestToUpdateFavoriteGroup()
    }

    /// Asynchronously remove favorite.
    /// - Parameter favoriteId: The ID of the favorite to remove.
    /// - Returns: A `SuccessResponse` objects.
    public func removeFavorite(
        favoriteId: String
    ) async throws -> SuccessResponse {
        let path = [path, favoriteId].joined(separator: "/")
        let response = try await client.request(path: path, method: .delete)
        return try await Serializer.shared.decode(response.data)
    }
}
