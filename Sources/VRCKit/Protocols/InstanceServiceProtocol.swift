//
//  InstanceServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol InstanceServiceProtocol: Sendable {
    /// Fetches an instance of a world using the specified world ID and instance ID.
    /// - Parameters:
    ///   - worldId: The ID of the world to fetch the instance from.
    ///   - instanceId: The ID of the instance to fetch.
    /// - Returns: An `Instance` object representing the fetched instance.
    /// - Throws: An error if the request fails or the data cannot be decoded.
    func fetchInstance(worldId: String, instanceId: String) async throws -> Instance

    /// Fetches an instance using the specified location string.
    /// - Parameter location: The location string in the format "worldId:instanceId".
    /// - Returns: An `Instance` object representing the fetched instance.
    /// - Throws: An error if the request fails or the data cannot be decoded.
    func fetchInstance(location: String) async throws -> Instance
}
