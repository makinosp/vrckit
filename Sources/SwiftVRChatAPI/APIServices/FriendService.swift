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
        _ client: APIClientAsync,
        n: Int = 60,
        offline: Bool = false
    ) async throws -> [Friend] {
        var request = URLComponents(string: friendsUrl)!
        request.queryItems = [URLQueryItem(name: "n", value: n.description)]
        guard let url = request.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(friendsUrl)"])
        }

        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            auth: true,
            apiKey: true
        )
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let friends: [Friend] = try decoder.decode([Friend].self, from: responseData)
        return friends
    }
}
