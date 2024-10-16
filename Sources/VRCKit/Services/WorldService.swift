//
//  WorldService.swift
//  VRCKit
//
//  Created by kiripoipoi on 2024/09/07.
//

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public final actor WorldService: APIService, WorldServiceProtocol {
    public let client: APIClient
    private let path = "worlds"
    private let limit = 100

    public func fetchWorld(worldId: String) async throws -> World {
        let response = try await client.request(path: "\(path)/\(worldId)", method: .get)
        return try await Serializer.shared.decode(response.data)
    }

    public func fetchFavoritedWorlds() async throws -> [FavoriteWorld] {
        var allFavorites = Set<FavoriteWorld>()
        var offset = 0
        while true {
            let batch = try await fetchFavoritedWorlds(n: limit, offset: offset)
            allFavorites.formUnion(batch)
            if batch.count < limit { break }
            offset += limit
        }
        return Array(allFavorites)
    }

    private func fetchFavoritedWorlds(n: Int, offset: Int) async throws -> [FavoriteWorld] {
        let queryItems = [
            URLQueryItem(name: "n", value: n.description),
            URLQueryItem(name: "offset", value: offset.description)
        ]
        let response = try await client.request(path: "\(path)/favorites", method: .get, queryItems: queryItems)
        let favoriteWorldWrapper: SafeDecodingArray<FavoriteWorld> = try await Serializer.shared.decode(response.data)
        return favoriteWorldWrapper.wrappedValue
    }
}
