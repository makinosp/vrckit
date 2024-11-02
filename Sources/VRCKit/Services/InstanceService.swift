//
//  InstanceService.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import MemberwiseInit

@MemberwiseInit(.public)
public final actor InstanceService: APIService, InstanceServiceProtocol {
    public let client: APIClient
    private let path = "instances"

    public func fetchInstance(worldId: String, instanceId: String) async throws -> Instance {
        let response = try await client.request(
            path: "\(path)/\(worldId):\(instanceId)",
            method: .get
        )
        return try Serializer.shared.decode(response.data)
    }

    public func fetchInstance(location: String) async throws -> Instance {
        let response = try await client.request(path: "\(path)/\(location)", method: .get)
        return try Serializer.shared.decode(response.data)
    }
}
