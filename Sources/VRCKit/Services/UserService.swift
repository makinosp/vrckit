//
//  UserService.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

public class UserService: APIService, UserServiceProtocol {
    let path = "users"

    /// Fetch a user
    public func fetchUser(userId: String) async throws -> UserDetail {
        let response = try await client.request(path: "\(path)/\(userId)", method: .get)
        return try Serializer.shared.decode(response.data)
    }

    /// Update user
    public func updateUser(id: String, editedInfo: EditableUserInfo) async throws {
        let requestData = try Serializer.shared.encode(editedInfo)
        _ = try await client.request(
            path: "\(path)/\(id)",
            method: .put,
            body: requestData
        )
    }
}
