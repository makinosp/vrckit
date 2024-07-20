//
//  WorldService.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

public class WorldService: APIService {
    let path = "worlds"

    public func fetchWorld(worldId: String) async throws -> World {
        let response = try await client.request(path: "\(path)/\(worldId)", method: .get)
        return try Serializer.shared.decode(response.data)
    }
}
