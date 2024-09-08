//
//  WorldPreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/09.
//

public final class WorldPreviewService: WorldService {
    override public func fetchWorld(worldId: String) async throws -> World {
        PreviewDataProvider.generateWorld()
    }

    override public func fetchFavoritedWorlds() async throws -> [World] {
        (0..<10).map { _ in PreviewDataProvider.generateWorld() }
    }
}
