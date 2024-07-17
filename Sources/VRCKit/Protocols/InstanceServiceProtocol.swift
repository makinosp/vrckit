//
//  InstanceServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol InstanceServiceProtocol {
    func fetchInstance(worldId: String, instanceId: String) async throws -> Instance
    func fetchInstance(location: String) async throws -> Instance
}
