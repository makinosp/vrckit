//
//  FriendModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/03.
//

import Foundation

public struct Friend: ProfileElementRepresentable, LocationRepresentable {
    public let bio: String?
    public var bioLinks: SafeDecodingArray<URL>
    public let avatarImageUrl: URL?
    public let avatarThumbnailUrl: URL?
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let platform: UserPlatform
    public let profilePicOverride: URL?
    public let status: UserStatus
    public let statusDescription: String
    public let tags: UserTags
    public let userIcon: URL?
    public let location: Location
    public let friendKey: String
}

public struct FriendsLocation: LocationRepresentable {
    public let location: Location
    public let friends: [Friend]
}

extension FriendsLocation: Hashable, Identifiable {
    public var id: Int { location.hashValue }
}
