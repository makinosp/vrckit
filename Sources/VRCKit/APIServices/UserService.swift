//
//  UserService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation


//
// MARK: User API
//

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct UserService {
    static let userUrl = "\(baseUrl)/users"

    /// Fetch a user
    public static func fetchUser(
        _ client: APIClientAsync,
        userId: String
    ) async throws -> UserDetail {
        let url = URL(string: "\(userUrl)/\(userId)")!

        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            auth: true,
            apiKey: true
        )
        let userDetail: UserDetail = try Util.shared.decoder.decode(UserDetail.self, from: responseData)
        return userDetail
    }

    /// Fetch uesrs
    public static func fetchUsers(
        _ client: APIClientAsync,
        userIds: [String]
    ) async throws -> [UserDetail] {
        var users: [(index: Int, user: UserDetail)] = []
        try await withThrowingTaskGroup(of: (index: Int, user: UserDetail).self) { group in
            for (index, userId) in userIds.enumerated() {
                group.addTask {
                    try await (
                        index: index,
                        user: UserService.fetchUser(client, userId: userId)
                    )
                }
            }
            for try await userDetail in group {
                users.append(userDetail)
            }
        }
        return users.sorted(by: { $0.index < $1.index }).map(\.user)
    }

    public static func updateUser(
        client: APIClientAsync,
        userID: String,
        statusDescription: String? = nil,
        tags: [String]? = nil,
        bio: String? = nil,
        bioLinks: [String]? = nil
    ) async throws -> User? {
        let url = URL(string: "\(userUrl)/\(userID)")!
        
        var userInfo: [String: Any] = [:]
        
        if let statusDescription = statusDescription {
            userInfo["statusDescription"] = statusDescription
        }
        
        if let tags = tags {
            userInfo["tags"] = tags
        }
        
        if let bio = bio {
            userInfo["bio"] = bio
        }
        
        if let bioLinks = bioLinks {
            userInfo["bioLinks"] = bioLinks
        }
        
        let httpBody: Data?
        do {
            httpBody = try JSONSerialization.data(withJSONObject: userInfo)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        
        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .put,
            auth: true,
            apiKey: true,
            contentType: .json,
            httpBody: httpBody
        )
        
        let user: User? = try JSONDecoder().decode(User?.self, from: responseData)
        return user
    }
}
