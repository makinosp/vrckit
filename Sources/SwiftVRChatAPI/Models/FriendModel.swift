//
//  FriendModel.swift
//  
//
//  Created by makinosp on 2024/03/03.
//

import Foundation

public struct Friend: Codable, Hashable, Identifiable {
    public let bio: String
    public let currentAvatarImageUrl: String
    public let currentAvatarThumbnailImageUrl: String
    public let developerType: String
    public let displayName: String
    public let id: String
    public let imageUrl: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let status: String
    public let statusDescription: String
    public let tags: [String]
    public let userIcon: String
    public let location: String
    public let friendKey: String
}
