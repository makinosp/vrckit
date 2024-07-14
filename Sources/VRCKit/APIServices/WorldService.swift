//
//  WorldService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: World API
//

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public class WorldService: APIService {
    let path = "worlds"

    public func fetchWorld(worldId: String) async throws -> World {
        let response = try await client.request(path: "\(path)/\(worldId)", method: .get)
        return try Serializer.shared.decode(response.data)
    }
}
