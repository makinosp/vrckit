//
//  ProfileProtocols.swift
//
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

/// Common properties the 3 structures User, Friend, and UserDetail
@available(macOS 12.0, *)
@available(iOS 15.0, *)
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

/// Common properties the 2 structures User and UserDetail
@available(macOS 12.0, *)
@available(iOS 15.0, *)
public protocol ProfileDetailRepresentable: ProfileElementRepresentable {
    var dateJoined: String { get }
    var lastActivity: Date { get }
}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
extension ProfileElementRepresentable {
    public var thumbnailUrl: URL? {
        if let userIcon = userIcon, !userIcon.isEmpty {
            return URL(string: userIcon)
        }
        guard let url = currentAvatarThumbnailImageUrl,
              let urlString = url.hasSuffix("256")
                ? String(url.dropLast(3)) + "512"
                : currentAvatarImageUrl else { return nil }
        return URL(string: urlString)
    }

    public var userIconUrl: URL? {
        guard let urlString = userIcon?.isEmpty ?? false
                ? currentAvatarThumbnailImageUrl
                : userIcon else { return nil }
        return URL(string: urlString)
    }
}
