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

    public func listFavoriteGroups() async throws -> [FavoriteGroup] {
        let path = "favorite/groups"
        let response = try await client.request(path: path, method: .get)
        return try Serializer.shared.decode(response.data)
    }

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

    public func listFavorites(
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
        return try Serializer.shared.decode(response.data)
    }

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

    public func addFavorite(
        type: FavoriteType,
        favoriteId: String,
        tag: String
    ) async throws -> Favorite {
        let path = "favorites"
        let requestData = try Serializer.shared.encode(
            RequestToAddFavorite(type: type, favoriteId: favoriteId, tags: [tag])
        )
        let response = try await client.request(path: path, method: .post, body: requestData)
        return try Serializer.shared.decode(response.data)
    }

    public func updateFavoriteGroup(
        source: FavoriteGroup,
        displayName: String,
        visibility: FavoriteGroup.Visibility
    ) async throws {
        let pathParams = ["favorite", "group", source.type.rawValue, source.name, source.ownerId]
        let path = pathParams.joined(separator: "/")
        let body = RequestToUpdateFavoriteGroup(displayName: displayName, visibility: visibility)
        let requestData = try Serializer.shared.encode(body)
        _ = try await client.request(path: path, method: .put, body: requestData)
    }

    public func removeFavorite(favoriteId: String) async throws -> SuccessResponse {
        let path = "favorites/\(favoriteId)"
        let response = try await client.request(path: path, method: .delete)
        return try Serializer.shared.decode(response.data)
    }
}
