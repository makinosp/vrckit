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

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct UserService {
    static let path = "users"

    /// Fetch a user
    public static func fetchUser(
        _ client: APIClient,
        userId: String
    ) async throws -> UserDetail {
        let response = try await client.request(path: "\(path)/\(userId)", method: .get)
        return try Serializer.shared.decode(response.data)
    }

    /// Update user
    public static func updateUser(
        _ client: APIClient,
        id: String
    ) async throws -> User {
        let response = try await client.request(path: "\(path)/\(id)", method: .put)
        return try Serializer.shared.decode(response.data)
    }
}
