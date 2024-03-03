//
//  UserModel.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

public struct User: Codable, Identifiable {

    public let requiresTwoFactorAuth: [String]?

    public let error: Response?

    public let id: String?
    public let displayName: String?
    public let userIcon: String?
    public let bio: String?
    public let bioLinks: [String]?
    public let statusDescription: String?
    public let username: String?

    //    public let pastDisplayName

    public let friends: [String]?

    public let currentAvatar: String?
    public let currentAvatarThumbnailImageUrl: String?

    public let currentAvatarAssetUrl: String?
    public let currentAvatarImageUrl: String?

    public let state: String?

    public let tags: [String]?

    public let status: String?
    public let worldId: String?
    public let instanceId: String?
    public let location: String?
    public let travelingToWorld: String?
    public let travelingToInstance: String?
    public let travelingToLocation: String?

    public let onlineFriends: [String]?
    public let activeFriends: [String]?
    public let offlineFriends: [String]?

}
