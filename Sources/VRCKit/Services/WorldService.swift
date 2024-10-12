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

    public func fetchWorld(worldId: String) async throws -> World {
        let response = try await client.request(path: "\(path)/\(worldId)", method: .get)
        return try await Serializer.shared.decode(response.data)
    }

    public func fetchFavoritedWorlds(n: Int = 100) async throws -> [FavoriteWorld] {
        let queryItems = [URLQueryItem(name: "n", value: n.description)]
        let response = try await client.request(path: "\(path)/favorites", method: .get, queryItems: queryItems)
        let favoriteWorldWrapper: SafeDecodingArray<FavoriteWorld> = try await Serializer.shared.decode(response.data)
        return favoriteWorldWrapper.wrappedValue
    }
}
