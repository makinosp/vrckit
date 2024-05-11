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
    ) async throws -> Result<[FavoriteGroup], ErrorResponse> {
        let response = try await client.request(
            url: URL(string: favoriteGroupUrl)!,
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        return Util.shared.decodeResponse(response.data)
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
        typealias FriendsResultSet = (favoriteGroupId: String, result: Result<[UserDetail], ErrorResponse>)
        var results: [FavoriteFriendDetail] = []
        try await withThrowingTaskGroup(of: FriendsResultSet.self) { taskGroup in
            for favoriteGroup in favorites {
                taskGroup.addTask {
                    try await FriendsResultSet(
                        favoriteGroupId: favoriteGroup.favoriteGroupId,
                        result: UserService.fetchUsers(
                            client,
                            userIds: favoriteGroup.favorites.map(\.favoriteId)
                        )
                    )
                }
            }
            for try await result in taskGroup {
                switch result.result {
                case .success(let friends):
                    results.append(FavoriteFriendDetail(favoriteGroupId: result.favoriteGroupId, friends: friends))
                case .failure(let error):
                    print(error)
                }
            }
        }
        return results
    }

//    public static func addFavorite(
//        client: APIClient,
//        type: FavoriteType = .friend,
//        favoriteId: String,
//        tags: [String]? = nil
//    ) async throws -> Favorite? {
//        let url = URL(string: "\(favoriteUrl)")!
//        
//        var favoriteInfo: [String: Any] = [:]
//        
//        favoriteInfo["type"] = type.rawValue
//        favoriteInfo["favoriteId"] = favoriteId
//        
//        if tags == nil {
//            switch type {
//            case .world:
//                favoriteInfo["tags"] = ["worlds1"]
//            case .avatar:
//                favoriteInfo["tags"] = ["avatars1"]
//            case .friend:
//                favoriteInfo["tags"] = ["group_0"]
//            }
//        } else {
//            favoriteInfo["tags"] = tags
//        }
//        
//        var httpBody: Data
//        
//        do {
//            httpBody = try JSONSerialization.data(withJSONObject: favoriteInfo)
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
//        
//        let (responseData, _) = try await client.request(
//            url: url,
//            httpMethod: .post,
//            auth: true,
//            apiKey: true,
//            contentType: .json,
//            httpBody: httpBody
//        )
//        let favorite: Favorite? = try JSONDecoder().decode(Favorite?.self, from: responseData)
//        return favorite
//    }
//    
//    public static func removeFavorite(
//        client: APIClient,
//        favoriteId: String
//    ) async throws -> Favorite? {
//        let url = URL(string: "\(favoriteUrl)/\(favoriteId)")!
//        let (responseData, _) = try await client.request(
//            url: url,
//            httpMethod: .delete,
//            auth: true,
//            apiKey: true
//        )
//        
//        let favorite: Favorite? = try JSONDecoder().decode(Favorite?.self, from: responseData)
//        return favorite
//    }
}
