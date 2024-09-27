//
//  WorldService.swift
//  VRCKit
//
//  Created by kiripoipoi on 2024/09/07.
//

public protocol WorldServiceProtocol: Sendable {
    func fetchWorld(worldId: String) async throws -> World
    func fetchFavoritedWorlds(n: Int) async throws -> [World]
}
