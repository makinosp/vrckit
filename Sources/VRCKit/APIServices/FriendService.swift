//
//  FriendService.swift
//
//
//  Created by makinosp on 2024/03/03.
//

import Foundation

//
// MARK: Friends API
//

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct FriendService {
    private static let path = "auth/user/friends"

    /// List information about friends.
    public static func fetchFriends(
        _ client: APIClient,
        offset: Int,
        n: Int = 60,
        offline: Bool = false
    ) async throws -> [Friend] {
        let queryItems = [
            URLQueryItem(name: "offset", value: offset.description),
            URLQueryItem(name: "n", value: n.description),
            URLQueryItem(name: "offline", value: offline.description)
        ]
        let response = try await client.request(path: path, method: .get)
        return try Serializer.shared.decode(response.data)
    }

    /// A helper function that splits a large API request tasks to fetch friend data concurrently,
    /// and then combines the results.
    public static func fetchFriends(
        _ client: APIClient,
        count: Int,
        offline: Bool = false
    ) async throws -> [Friend] {
        typealias ResultSet = (offset: Int, friends: [Friend])
        var results: [ResultSet] = []
        let n = 100
        if count <= n {
            return try await fetchFriends(
                client,
                offset: 0,
                n: count,
                offline: offline
            )
        }
        try await withThrowingTaskGroup(of: ResultSet.self) { taskGroup in
            for offset in stride(from: 0, to: count, by: n) {
                taskGroup.addTask { [weak client] in
                    guard let client = client else {
                        throw VRCKitError.clientDeallocated
                    }
                    let friends = try await fetchFriends(
                        client,
                        offset: offset,
                        n: n,
                        offline: offline
                    )
                    return ResultSet(offset: offset, friends: friends)
                }
            }
            for try await result in taskGroup {
                results.append(result)
            }
        }
        return results
            .sorted { $0.offset > $1.offset }
            .flatMap { $0.friends }
    }

    public static func unfriend(_ client: APIClient, id: String) async throws {
        try await client.request(path: "\(path)/\(id)", method: .delete)
    }

    public static func friendsGroupedByLocation(_ friends: [Friend]) -> [FriendsLocation] {
        Dictionary(grouping: friends, by: \.location)
            .sorted { $0.value.count > $1.value.count }
            .map { dictionary in
                FriendsLocation(location: dictionary.key, friends: dictionary.value)
            }
    }
}
