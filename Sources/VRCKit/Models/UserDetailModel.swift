//
//  UserDetailModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

public typealias Tag = String

public struct UserDetail: ProfileDetailRepresentable, LocationRepresentable {
    public var bio: String?
    public var bioLinks: SafeDecodingArray<URL>
    public let avatarImageUrl: URL?
    public let avatarThumbnailUrl: URL?
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let profilePicOverride: URL?
    public let state: User.State
    public let status: UserStatus
    public var statusDescription: String
    public var tags: Tags
    public let userIcon: URL?
    public let location: String
    public let friendKey: String
    public let dateJoined: String
    public var note: String
    public let lastActivity: Date

    public struct Tags: Codable, Hashable {
        let systemTags: [SystemTag]
        var languageTags: [LanguageTag]
    }
}

public extension UserDetail.Tags {
    init() {
        systemTags = []
        languageTags = []
    }
}

public extension UserDetail.Tags {
    init(from decoder: Decoder) throws {
        var systemTags: [SystemTag] = []
        var languageTags: [LanguageTag] = []
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let systemTag = try? container.decode(SystemTag.self)
            let languageTag = try? container.decode(LanguageTag.self)
            if let systemTag = systemTag {
                systemTags.append(systemTag)
            }
            if let languageTag = languageTag {
                languageTags.append(languageTag)
            }
        }
        self.systemTags = systemTags
        self.languageTags = languageTags
    }
}

extension UserDetail: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        bioLinks = try container.decodeSafeNullableArray(URL.self, forKey: .bioLinks)
        avatarImageUrl = try? container.decodeIfPresent(URL.self, forKey: .avatarImageUrl)
        avatarThumbnailUrl = try? container.decodeIfPresent(URL.self, forKey: .avatarThumbnailUrl)
        displayName = try container.decode(String.self, forKey: .displayName)
        id = try container.decode(String.self, forKey: .id)
        isFriend = try container.decode(Bool.self, forKey: .isFriend)
        lastLogin = try container.decode(Date.self, forKey: .lastLogin)
        lastPlatform = try container.decode(String.self, forKey: .lastPlatform)
        profilePicOverride = try? container.decodeIfPresent(URL.self, forKey: .profilePicOverride)
        state = try container.decode(User.State.self, forKey: .state)
        status = try container.decode(UserStatus.self, forKey: .status)
        statusDescription = try container.decode(String.self, forKey: .statusDescription)
        tags = try container.decode(Tags.self, forKey: .tags)
        userIcon = try? container.decodeIfPresent(URL.self, forKey: .userIcon)
        location = try container.decode(String.self, forKey: .location)
        friendKey = try container.decode(String.self, forKey: .friendKey)
        dateJoined = try container.decode(String.self, forKey: .dateJoined)
        note = try container.decode(String.self, forKey: .note)
        lastActivity = try container.decode(Date.self, forKey: .lastActivity)
    }
}

extension UserDetail {
    private enum CodingKeys: String, CodingKey {
        case bio
        case bioLinks
        case avatarImageUrl = "currentAvatarImageUrl"
        case avatarThumbnailUrl = "currentAvatarThumbnailImageUrl"
        case displayName
        case id
        case isFriend
        case lastLogin
        case lastPlatform
        case profilePicOverride
        case state
        case status
        case statusDescription
        case tags
        case userIcon
        case location
        case friendKey
        case dateJoined
        case note
        case lastActivity
    }
}

public struct EditableUserInfo: Codable, Hashable {
    public var bio: String
    public var bioLinks: [URL]
    public var status: UserStatus
    public var statusDescription: String
    public var tags: [Tag]
}

public extension EditableUserInfo {
    init(detail: any ProfileDetailRepresentable) {
        bio = detail.bio ?? ""
        bioLinks = detail.bioLinks.elements
        status = detail.status
        statusDescription = detail.statusDescription
//        tags = detail.tags
        tags = []
    }
}
