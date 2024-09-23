//
//  WorldService.swift
//  VRCKit
//
//  Created by kiripoipoi on 2024/09/07.
//

public final class WorldService: APIService, WorldServiceProtocol {
    let client: APIClient
    private let path = "worlds"

    init(client: APIClient) {
        self.client = client
    }

    public func fetchWorld(worldId: String) async throws -> World {
        let response = try await client.request(path: "\(path)/\(worldId)", method: .get)
        return try await Serializer.shared.decode(response.data)
    }

    public func fetchFavoritedWorlds() async throws -> [World] {
        let response = try await client.request(path: "\(path)/favorites", method: .get)
        let favoriteWorldWrapper: FavoriteWorldWrapper = try await Serializer.shared.decode(response.data)
        return favoriteWorldWrapper.worlds
    }
}
