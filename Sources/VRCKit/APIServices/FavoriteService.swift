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
    private static let favoriteUrl = "\(baseUrl)/favorites"
    private static let favoriteGroupUrl = "\(baseUrl)/favorite/groups"

    /// Asynchronously retrieves a list of favorite groups from the server.
    /// - Parameter client: The API client used to make the network request.
    /// - Returns: An array of `FavoriteGroup` objects.
    /// - Throws: An error if the network request or decoding of the response fails.
    public static func listFavoriteGroups(
        _ client: APIClient
    ) async throws -> [FavoriteGroup] {
        let response = try await client.request(
            url: URL(string: favoriteGroupUrl)!,
            httpMethod: .get
        )
        return try Util.shared.decode(response.data)
    }

    public static func listFavorites(
        _ client: APIClient,
        n: Int = 60,
        type: FavoriteType,
        tag: String? = nil
    ) async throws -> [Favorite] {
        var request = URLComponents(string: favoriteUrl)!
        request.queryItems = [
            URLQueryItem(name: "n", value: n.description),
            URLQueryItem(name: "type", value: type.rawValue)
        ]
        if let tag = tag {
            request.queryItems?.append(URLQueryItem(name: "tag", value: tag.description))
        }
        guard let url = request.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(favoriteUrl)"])
        }

        let response = try await client.request(
            url: url,
            httpMethod: .get
        )
        return try Util.shared.decode(response.data)
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

    /// Fetch friend details from favorite IDs
    public static func fetchFriendsInGroups(
        _ client: APIClient,
        favorites: [FavoriteDetail]
    ) async throws -> [FavoriteFriendDetail] {
        var results: [FavoriteFriendDetail] = []
        try await withThrowingTaskGroup(of: FavoriteFriendDetail.self) { taskGroup in
            for favoriteGroup in favorites {
                taskGroup.addTask {
                    try await FavoriteFriendDetail(
                        favoriteGroupId: favoriteGroup.favoriteGroupId,
                        friends: UserService.fetchUsers(
                            client,
                            userIds: favoriteGroup.favorites.map(\.favoriteId)
                        )
                    )
                }
            }
            for try await result in taskGroup {
                results.append(result)
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
        let requestData = try Util.shared.encode(
            RequestToAddFavorite(type: type, favoriteId: favoriteId, tags: [tag])
        )
        let response = try await client.request(
            url: URL(string: "\(favoriteUrl)")!,
            httpMethod: .post,
            httpBody: requestData
        )
        return try Util.shared.decode(response.data)
    }

    public static func removeFavorite(
        _ client: APIClient,
        favoriteId: String
    ) async throws -> SuccessResponse {
        let response = try await client.request(
            url: URL(string: "\(favoriteUrl)/\(favoriteId)")!,
            httpMethod: .delete
        )
        return try Util.shared.decode(response.data)
    }
}
