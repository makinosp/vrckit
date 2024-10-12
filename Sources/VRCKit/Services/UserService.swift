//
//  UserService.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import MemberwiseInit

@MemberwiseInit(.public)
public final actor UserService: APIService, UserServiceProtocol {
    public let client: APIClient
    private let path = "users"

    /// Fetch a user
    public func fetchUser(userId: String) async throws -> UserDetail {
        let response = try await client.request(path: "\(path)/\(userId)", method: .get)
        return try await Serializer.shared.decode(response.data)
    }

    /// Update user
    public func updateUser(id: String, editedInfo: EditableUserInfo) async throws {
        let requestData = try await Serializer.shared.encode(editedInfo)
        _ = try await client.request(
            path: "\(path)/\(id)",
            method: .put,
            body: requestData
        )
    }
}
