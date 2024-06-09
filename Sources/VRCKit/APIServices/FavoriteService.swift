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
public typealias FavoriteFriendDetail = (favoriteGroupId: String, friends: [UserDetail])

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct FavoriteService {

    private static let favoriteUrl = "\(baseUrl)/favorites"
    private static let favoriteGroupUrl = "\(baseUrl)/favorite/groups"

    public static func listFavoriteGroups(
        _ client: APIClient
    ) async throws -> [FavoriteGroup] {
        let response = try await client.request(
            url: URL(string: favoriteGroupUrl)!,
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        return try Util.shared.decodeResponse(response.data).get()
    }

    public static func listFavorites(
        _ client: APIClient,
        n: Int = 60,
        type: FavoriteType,
        tag: String? = nil
    ) async throws -> Result<[Favorite], ErrorResponse> {
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
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        return Util.shared.decodeResponse(response.data) as Result<[Favorite], ErrorResponse>
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
                        ).get()
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
    ) async throws -> Result<Favorite, ErrorResponse> {
        let requestData = try Util.shared.encodeRequest(
            RequestToAddFavorite(type: type, favoriteId: favoriteId, tags: [tag]),
            keyEncodingStrategy: .useDefaultKeys
        ).get()

        let response = try await client.request(
            url: URL(string: "\(favoriteUrl)")!,
            httpMethod: .post,
            cookieKeys: [.auth, .apiKey],
            httpBody: requestData
        )
        return try Util.shared.decodeResponse(response.data) as Result<Favorite, ErrorResponse>
    }
    
    public static func removeFavorite(
        _ client: APIClient,
        favoriteId: String
    ) async throws -> Result<SuccessResponse, ErrorResponse> {
        let response = try await client.request(
            url: URL(string: "\(favoriteUrl)/\(favoriteId)")!,
            httpMethod: .delete,
            cookieKeys: [.auth, .apiKey]
        )
        return try Util.shared.decodeResponse(response.data) as Result<SuccessResponse, ErrorResponse>
    }
}
