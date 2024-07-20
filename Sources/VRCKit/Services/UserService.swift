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
    public func updateUser(id: String) async throws -> User {
        let response = try await client.request(path: "\(path)/\(id)", method: .put)
        return try Serializer.shared.decode(response.data)
    }
}
