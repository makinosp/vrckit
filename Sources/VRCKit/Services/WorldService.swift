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
    private let maxCount = 400
    private typealias FavoriteWorldsWithOffset = (offset: Int, worlds: [FavoriteWorld])

    public func fetchWorld(worldId: String) async throws -> World {
        let response = try await client.request(path: "\(path)/\(worldId)", method: .get)
        return try await Serializer.shared.decode(response.data)
    }

    public func fetchFavoritedWorlds() async throws -> [FavoriteWorld] {
        try await withThrowingTaskGroup(of: FavoriteWorldsWithOffset.self) { taskGroup in
            for offset in Array(stride(from: 0, to: maxCount, by: limit)) {
                taskGroup.addTask { [weak self] in
                    guard let self = self else { return (offset, []) }
                    let worlds = try await fetchFavoritedWorlds(n: limit, offset: offset)
                    return (offset, worlds)
                }
            }
            var resultsDict: [FavoriteWorldsWithOffset] = []
            for try await result in taskGroup { resultsDict.append(result) }
            return resultsDict
                .sorted { $0.offset < $1.offset }
                .flatMap { $0.worlds }
        }
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
