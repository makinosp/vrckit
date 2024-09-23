//
//  UserServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol UserServiceProtocol: Sendable {
    func fetchUser(userId: String) async throws -> UserDetail
    func updateUser(id: String, editedInfo: EditableUserInfo) async throws
}
