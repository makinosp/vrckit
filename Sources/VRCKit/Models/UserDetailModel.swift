//
//  UserDetailModel.swift
//
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

@available(macOS 12.0, *)
@available(iOS 15.0, *)
extension UserDetail: ProfileDetailRepresentable, LocationRepresentable {}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct UserDetail: Codable {
    public let bio: String?
    public let bioLinks: [String]?
    public let currentAvatarImageUrl: String?
    public let currentAvatarThumbnailImageUrl: String?
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let profilePicOverride: String?
    public let state: User.State
    public let status: User.Status
    public let statusDescription: String
    public let tags: [String]
    public let userIcon: String?
    public let location: String
    public let friendKey: String
    public let dateJoined: String
    public var note: String
    public let lastActivity: Date
}
