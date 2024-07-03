//
//  InstanceService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: Instance API
//

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct InstanceService {
    static let path = "instances"

    public static func fetchInstance(
        _ client: APIClient,
        worldId: String,
        instanceId: String
    ) async throws -> Instance {
        let response = try await client.request(
            path: "\(path)/\(worldId):\(instanceId)",
            method: .get
        )
        return try Util.shared.decode(response.data)
    }

    public static func fetchInstance(
        _ client: APIClient,
        location: String
    ) async throws -> Instance {
        let response = try await client.request(path: "\(path)/\(location)", method: .get)
        return try Util.shared.decode(response.data)
    }
}
