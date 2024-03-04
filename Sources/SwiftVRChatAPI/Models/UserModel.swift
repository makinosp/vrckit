//
//  UserModel.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

public struct User: Codable, Identifiable {
    public let allowAvatarCopying: Bool
    public let bio: String
    public let bioLinks: [String]
    public let currentAvatar: String
    public let currentAvatarAssetUrl: String
    public let currentAvatarImageUrl: String
    public let currentAvatarThumbnailImageUrl: String
    public let displayName: String
    public let id: String
    public let pastDisplayNames: [DisplayName]
    public let state: String
    public let status: String
    public let statusDescription: String
    public let tags: [String]
    public let twoFactorAuthEnabled: Bool
    public let userIcon: String

    public struct DisplayName: Codable {
        public let displayName: String
        public let updatedAt: Date
    }
}

public struct WrappedUserResponse: Codable {
    public let user: User?
    public let requiresTwoFactorAuth: [String]
}
