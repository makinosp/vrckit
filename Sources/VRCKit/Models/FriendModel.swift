//
//  FriendModel.swift
//  
//
//  Created by makinosp on 2024/03/03.
//

import Foundation

public enum Status: String, Codable, CaseIterable, Identifiable {
    case joinMe = "join me"
    case active
    case askMe = "ask me"
    case busy
    case offline

    public var description: String {
        switch self {
        case .joinMe:
            "Join Me"
        case .active:
            "Online"
        case .askMe:
            "Ask Me"
        case .busy:
            "Do Not Disturb"
        case .offline:
            "Offline"
        }
    }

    public var id: Int {
        self.hashValue
    }
}

public struct Friend: Codable, ProfileElementRepresentable {
    public let bio: String?
    public let bioLinks: [String]?
    public let currentAvatarImageUrl: String
    public let currentAvatarThumbnailImageUrl: String
    public let developerType: String
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let profilePicOverride: String
    public let status: Status
    public let statusDescription: String
    public let tags: [String]
    public let userIcon: String
    public let location: String
    public let friendKey: String
}
