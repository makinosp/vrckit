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
    private static let friendsUrl = "\(baseUrl)/auth/user/friends"

    public static func fetchFriends(
        _ client: APIClient,
        offset: Int,
        n: Int = 60,
        offline: Bool = false
    ) async throws -> [Friend] {
        var request = try Util.shared.urlComponents(friendsUrl)
        request.queryItems = [
            URLQueryItem(name: "offset", value: offset.description),
            URLQueryItem(name: "n", value: n.description),
            URLQueryItem(name: "offline", value: offline.description)
        ]
        guard let url = request.url else {
            throw VRCKitError.invalidRequest("Invalid Request: \(request)")
        }
        let response = try await client.request(
            url: url,
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        return try Util.shared.decode(response.data)
    }

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
                taskGroup.addTask {
                    try await ResultSet(
                        offset: offset,
                        friends: try await fetchFriends(
                            client,
                            offset: offset,
                            n: n,
                            offline: offline
                        )
                    )
                }
            }
            for try await result in taskGroup {
                results.append(result)
            }
        }
        return results
            .sorted(by: { $0.offset > $1.offset })
            .flatMap { $0.friends }
    }
}
