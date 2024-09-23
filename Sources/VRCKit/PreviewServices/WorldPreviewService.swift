//
//  WorldPreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/09.
//

public final actor WorldPreviewService: APIService, WorldServiceProtocol {
    let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }

    public func fetchWorld(worldId: String) async throws -> World {
        PreviewDataProvider.generateWorld()
    }

    public func fetchFavoritedWorlds(n: Int = 100) async throws -> [World] {
        (0..<10).map { _ in PreviewDataProvider.generateWorld() }
    }
}
