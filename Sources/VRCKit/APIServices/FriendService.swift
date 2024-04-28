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
    ) async throws -> Result<[Friend], ErrorResponse> {
        var request = URLComponents(string: friendsUrl)!
        request.queryItems = [
            URLQueryItem(name: "offset", value: offset.description),
            URLQueryItem(name: "n", value: n.description),
            URLQueryItem(name: "offline", value: offline.description)
        ]
        guard let url = request.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(friendsUrl)"])
        }

        let response = try await client.request(
            url: url,
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        return Util.shared.decodeResponse(response.data)
    }
}
