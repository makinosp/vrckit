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

public typealias FavoriteDetail = (favoriteGroupId: String, favorites: [Favorite])
@available(macOS 12.0, *)
@available(iOS 15.0, *)
public typealias FavoriteFriendDetail = (favoriteGroupId: String, friends: [UserDetail])

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct FavoriteService {
    private static let path = "favorites"

    /// Asynchronously retrieves a list of favorite groups from the server.
    /// - Parameter client: The API client used to make the network request.
    /// - Returns: An array of `FavoriteGroup` objects.
    /// - Throws: An error if the network request or decoding of the response fails.
    public static func listFavoriteGroups(
        _ client: APIClient
    ) async throws -> [FavoriteGroup] {
        let path = "favorite/groups"
        let response = try await client.request(path: path, method: .get)
        return try Serializer.shared.decode(response.data)
    }

    public static func listFavorites(
        _ client: APIClient,
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
    public static func fetchFavoriteGroupDetails(
        _ client: APIClient,
        favoriteGroups: [FavoriteGroup]
    ) async throws -> [FavoriteDetail] {
        var results: [FavoriteDetail] = []
        try await withThrowingTaskGroup(of: FavoriteDetail.self) { taskGroup in
            for favoriteGroup in favoriteGroups.filter({ $0.type == .friend }) {
                taskGroup.addTask {
                    try await FavoriteDetail(
                        favoriteGroupId: favoriteGroup.id,
                        favorites: FavoriteService.listFavorites(
                            client,
                            type: .friend,
                            tag: favoriteGroup.name
                        )
                    )
                }
            }
            for try await favoriteGroupDetail in taskGroup {
                results.append(favoriteGroupDetail)
            }
        }
        return results
    }

    public static func addFavorite(
        _ client: APIClient,
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

    public static func removeFavorite(
        _ client: APIClient,
        favoriteId: String
    ) async throws -> SuccessResponse {
        let response = try await client.request(path: path, method: .delete)
        return try Serializer.shared.decode(response.data)
    }
}
