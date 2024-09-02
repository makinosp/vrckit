//
//  ProfileProtocols.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

/// A protocol representing common properties for user profile elements.
/// This protocol can be adopted by structures such as User, Friend, and UserDetail.
public protocol ProfileElementRepresentable: Hashable, Identifiable {
    var bio: String? { get }
    var bioLinks: SafeDecodingArray<URL> { get }
    var avatarImageUrl: URL? { get }
    var avatarThumbnailUrl: URL? { get }
    var displayName: String { get }
    var id: String { get }
    var isFriend: Bool { get }
    var lastLogin: Date { get }
    var lastPlatform: String { get }
    var platform: UserPlatform { get }
    var profilePicOverride: URL? { get }
    var status: UserStatus { get }
    var statusDescription: String { get }
    var tags: UserTags { get }
    var userIcon: URL? { get }
    var friendKey: String { get }
}

public enum UserPlatform: String, Codable {
    case android, ios, standalonewindows, web
    case blank = ""
}

/// A protocol representing detailed profile properties for users.
/// This protocol extends ProfileElementRepresentable and can be adopted by structures like User and UserDetail.
public protocol ProfileDetailRepresentable: ProfileElementRepresentable {
    var dateJoined: Date? { get }
    var lastActivity: Date { get }
    var state: User.State { get }
}
