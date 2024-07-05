//
//  ProfileProtocols.swift
//
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

/// A protocol representing common properties for user profile elements.
/// This protocol can be adopted by structures such as User, Friend, and UserDetail.
@available(iOS 13.0, *)
public protocol ProfileElementRepresentable: Hashable, Identifiable {
    var bio: String? { get }
    var bioLinks: [String]? { get }
    var currentAvatarImageUrl: String? { get }
    var currentAvatarThumbnailImageUrl: String? { get }
    var displayName: String { get }
    var id: String { get }
    var isFriend: Bool { get }
    var lastLogin: Date { get }
    var lastPlatform: String { get }
    var profilePicOverride: String? { get }
    var status: User.Status { get }
    var statusDescription: String { get }
    var tags: [String] { get }
    var userIcon: String? { get }
    var friendKey: String { get }
}

/// A protocol representing detailed profile properties for users.
/// This protocol extends ProfileElementRepresentable and can be adopted by structures like User and UserDetail.
@available(iOS 13.0, *)
public protocol ProfileDetailRepresentable: ProfileElementRepresentable {
    var dateJoined: String { get }
    var lastActivity: Date { get }
    var state: User.State { get }
}

@available(iOS 13.0, *)
public extension ProfileElementRepresentable {
    var thumbnailUrl: URL? {
        if let userIcon = userIcon, !userIcon.isEmpty {
            return URL(string: userIcon)
        }
        guard let url = currentAvatarThumbnailImageUrl,
              let urlString = url.hasSuffix("256")
                ? String(url.dropLast(3)) + "512"
                : currentAvatarImageUrl else { return nil }
        return URL(string: urlString)
    }

    var userIconUrl: URL? {
        guard let urlString = userIcon?.isEmpty ?? false
                ? currentAvatarThumbnailImageUrl
                : userIcon else { return nil }
        return URL(string: urlString)
    }
}
