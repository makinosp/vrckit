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

    public enum Status: String, CaseIterable, Identifiable {
        case joinMe = "join me"
        case active
        case askMe = "ask me"
        case busy
        case offline

        public var id: Int {
            self.hashValue
        }
    }

    public static func fetchFriends(
        _ client: APIClientAsync,
        offset: Int,
        n: Int = 60,
        offline: Bool = false
    ) async throws -> [Friend] {
        var request = URLComponents(string: friendsUrl)!
        request.queryItems = [
            URLQueryItem(name: "offset", value: offset.description),
            URLQueryItem(name: "n", value: n.description),
            URLQueryItem(name: "offline", value: offline.description)
        ]
        guard let url = request.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(friendsUrl)"])
        }

        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            auth: true,
            apiKey: true
        )
        let friends: [Friend] = try Util.shared.decoder.decode([Friend].self, from: responseData)
        return friends
    }
}
