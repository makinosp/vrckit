//
//  WorldService.swift
//  VRCKit
//
//  Created by kiripoipoi on 2024/09/07.
//

// WorldServiceProtocol.swift
public protocol WorldServiceProtocol {
    func fetchWorld(worldId: String) async throws -> World
    func fetchFavoritedWorlds() async throws -> [World]
}
