//
//  InstanceService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public class InstanceService: APIService, InstanceServiceProtocol {
    let path = "instances"

    /// Fetches an instance of a world using the specified world ID and instance ID.
    /// - Parameters:
    ///   - worldId: The ID of the world to fetch the instance from.
    ///   - instanceId: The ID of the instance to fetch.
    /// - Returns: An `Instance` object representing the fetched instance.
    /// - Throws: An error if the request fails or the data cannot be decoded.
    public func fetchInstance(worldId: String, instanceId: String) async throws -> Instance {
        let response = try await client.request(
            path: "\(path)/\(worldId):\(instanceId)",
            method: .get
        )
        return try Serializer.shared.decode(response.data)
    }

    /// Fetches an instance using the specified location string.
    /// - Parameter location: The location string in the format "worldId:instanceId".
    /// - Returns: An `Instance` object representing the fetched instance.
    /// - Throws: An error if the request fails or the data cannot be decoded.
    public func fetchInstance(location: String) async throws -> Instance {
        let response = try await client.request(path: "\(path)/\(location)", method: .get)
        return try Serializer.shared.decode(response.data)
    }
}
