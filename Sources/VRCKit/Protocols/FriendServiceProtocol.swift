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
    /// Groups friends by their location and returns a sorted list of FriendsLocation objects.
    /// - Parameter friends: An array of `Friend`` objects to be grouped by location.
    /// - Returns: A list of `FriendsLocation` objects, sorted by the number of friends in each location.
    func friendsGroupedByLocation(_ friends: [Friend]) async -> [FriendsLocation] {
        Dictionary(grouping: friends, by: \.location)
            .sorted { $0.value.count > $1.value.count }
            .map { dictionary in
                FriendsLocation(location: dictionary.key, friends: dictionary.value)
            }
    }
}
