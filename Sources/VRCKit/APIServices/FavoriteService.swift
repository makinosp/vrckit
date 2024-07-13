//
//  FavoriteService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: Favorite API
//

public protocol FavoriteServiceProtocol {
    func listFavoriteGroups() async throws -> [FavoriteGroup]
    func listFavorites(n: Int, type: FavoriteType, tag: String?) async throws -> [Favorite]
    func fetchFavoriteGroupDetails(favoriteGroups: [FavoriteGroup]) async throws -> [FavoriteDetail]
    func addFavorite(type: FavoriteType, favoriteId: String, tag: String) async throws -> Favorite
    func removeFavorite(favoriteId: String) async throws -> SuccessResponse
}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public class FavoriteService: FavoriteServiceProtocol {
    private let path = "favorites"
    private let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }

    /// Asynchronously retrieves a list of favorite groups from the server.
    /// - Returns: An array of `FavoriteGroup` objects.
    /// - Throws: An error if the network request or decoding of the response fails.
    public func listFavoriteGroups() async throws -> [FavoriteGroup] {
        let path = "favorite/groups"
        let response = try await client.request(path: path, method: .get)
        return try Serializer.shared.decode(response.data)
    }

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
        return try Serializer.shared.decode(response.data)
    }

    /// Fetch a list of favorite IDs for each favorite group
    public func fetchFavoriteGroupDetails(
        favoriteGroups: [FavoriteGroup]
    ) async throws -> [FavoriteDetail] {
        var results: [FavoriteDetail] = []
        try await withThrowingTaskGroup(of: FavoriteDetail.self) { taskGroup in
            for favoriteGroup in favoriteGroups.filter({ $0.type == .friend }) {
                taskGroup.addTask {
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

    public func addFavorite(
        type: FavoriteType,
        favoriteId: String,
        tag: String
    ) async throws -> Favorite {
        let requestData = try Serializer.shared.encode(
            RequestToAddFavorite(type: type, favoriteId: favoriteId, tags: [tag])
        )
        let response = try await client.request(path: path, method: .post, body: requestData)
        return try Serializer.shared.decode(response.data)
    }

    public func removeFavorite(
        favoriteId: String
    ) async throws -> SuccessResponse {
        let response = try await client.request(path: path, method: .delete)
        return try Serializer.shared.decode(response.data)
    }
}
