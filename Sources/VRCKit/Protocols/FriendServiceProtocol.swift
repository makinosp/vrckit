//
//  FriendServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol FriendServiceProtocol {
    func fetchFriends(offset: Int, n: Int, offline: Bool) async throws -> [Friend]
    func fetchFriends(count: Int, offline: Bool) async throws -> [Friend]
    func unfriend(id: String) async throws
    func friendsGroupedByLocation(_ friends: [Friend]) async -> [FriendsLocation]
}
