//
//  UserService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: User API
//

public protocol UserServiceProtocol {
    func fetchUser(userId: String) async throws -> UserDetail
    func updateUser(id: String) async throws -> User
}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public class UserService: UserServiceProtocol {
    let path = "users"
    let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }

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
