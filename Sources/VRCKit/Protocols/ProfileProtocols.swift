//
//  ProfileProtocols.swift
//
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public protocol ProfileElementRepresentable: Hashable, Identifiable {
    var bio: String? { get }
    var bioLinks: [String]? { get }
    var currentAvatarImageUrl: String { get }
    var currentAvatarThumbnailImageUrl: String { get }
    var developerType: String { get }
    var displayName: String { get }
    var id: String { get }
    var isFriend: Bool { get }
    var lastLogin: Date { get }
    var lastPlatform: String { get }
    var profilePicOverride: String { get }
    var status: User.Status { get }
    var statusDescription: String { get }
    var tags: [String] { get }
    var userIcon: String { get }
    var friendKey: String { get }
}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public protocol ProfileDetailRepresentable: ProfileElementRepresentable {
    var dateJoined: String { get }
    var lastActivity: Date { get }
}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public protocol UserDetailRepresentable: ProfileDetailRepresentable {
    var note: String { get set }
}
