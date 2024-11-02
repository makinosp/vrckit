//
//  FriendServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol FriendServiceProtocol: Sendable {
    /// Fetches a list of friends with pagination support.
    /// - Parameters:
    ///   - offset: The offset to start retrieving friends from.
    ///   - n: The maximum number of friends to retrieve in the request (default is 60).
    ///   - offline: A Boolean indicating whether to include offline friends.
    /// - Returns: An array of `Friend` objects representing the user's friends.
    /// - Throws: An error if the request fails or decoding is unsuccessful.
    func fetchFriends(offset: Int, n: Int, offline: Bool) async throws -> [Friend]

    /// Fetches a list of friends up to a specified count, using multiple requests if needed.
    /// - Parameters:
    ///   - count: The total number of friends to retrieve.
    ///   - offline: A Boolean indicating whether to include offline friends.
    /// - Returns: An array of `Friend` objects representing the user's friends.
    /// - Throws: An error if any request fails or decoding is unsuccessful.
    func fetchFriends(count: Int, offline: Bool) async throws -> [Friend]

    /// Removes a friend with the specified ID.
    /// - Parameter id: The ID of the friend to be removed.
    /// - Throws: An error if the request fails.
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
