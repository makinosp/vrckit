//
//  FriendServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol FriendServiceProtocol: Sendable {
    func fetchFriends(offset: Int, n: Int, offline: Bool) async throws -> [Friend]
    func fetchFriends(count: Int, offline: Bool) async throws -> [Friend]
    func unfriend(id: String) async throws
}

public extension FriendServiceProtocol {
    func friendsGroupedByLocation(_ friends: [Friend]) async -> [FriendsLocation] {
        Dictionary(grouping: friends, by: \.location)
            .sorted { $0.value.count > $1.value.count }
            .map { dictionary in
                FriendsLocation(location: dictionary.key, friends: dictionary.value)
            }
    }
}
