//
//  UserServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol UserServiceProtocol: Sendable {
    /// Fetches detailed information about a specific user.
    /// - Parameter userId: The ID of the user to retrieve.
    /// - Returns: A `UserDetail` object containing detailed information about the specified user.
    /// - Throws: An error if the request fails or decoding is unsuccessful.
    func fetchUser(userId: String) async throws -> UserDetail

    /// Updates the information for a specific user.
    /// - Parameters:
    ///   - id: The ID of the user to update.
    ///   - editedInfo: An `EditableUserInfo` object containing the updated user information.
    /// - Throws: An error if the request fails or encoding is unsuccessful.
    func updateUser(id: String, editedInfo: EditableUserInfo) async throws
}
