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
public struct WorldService {
    static let path = "worlds"

    public static func fetchWorld(_ client: APIClient, worldId: String) async throws -> World {
        let response = try await client.request(path: "\(path)/\(worldId)", httpMethod: .get)
        return try Util.shared.decode(response.data)
    }
}
