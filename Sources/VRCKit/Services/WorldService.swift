//
//  WorldService.swift
//  VRCKit
//
//  Created by kiripoipoi on 2024/09/07.
//

import Foundation

public final actor WorldService: APIService, WorldServiceProtocol {
    let client: APIClient
    private let path = "worlds"

    public init(client: APIClient) {
        self.client = client
    }

    public func fetchWorld(worldId: String) async throws -> World {
        let response = try await client.request(path: "\(path)/\(worldId)", method: .get)
        return try await Serializer.shared.decode(response.data)
    }

    public func fetchFavoritedWorlds(n: Int = 100) async throws -> [World] {
        let queryItems = [URLQueryItem(name: "n", value: n.description)]
        let response = try await client.request(path: "\(path)/favorites", method: .get, queryItems: queryItems)
        let favoriteWorldWrapper: FavoriteWorldWrapper = try await Serializer.shared.decode(response.data)
        return favoriteWorldWrapper.worlds
    }
}
