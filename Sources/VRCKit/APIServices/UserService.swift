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
        _ client: APIClient,
        userId: String
    ) async throws -> UserDetail {
        let url = URL(string: "\(userUrl)/\(userId)")!
        let response = try await client.request(
            url: url,
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        return try Util.shared.decode(response.data)
    }

    /// Fetch uesrs
    public static func fetchUsers(
        _ client: APIClient,
        userIds: [String]
    ) async throws -> [UserDetail] {
        typealias ResultSet = (index: Int, user: UserDetail)
        var users: [ResultSet?] = []
        try await withThrowingTaskGroup(of: ResultSet?.self) { taskGroup in
            for (index, userId) in userIds.enumerated() {
                taskGroup.addTask {
                    do {
                        return try await (
                            index: index,
                            user: UserService.fetchUser(client, userId: userId)
                        )
                    } catch let error as VRCKitError {
                        return nil
                    }
                }
            }
            for try await result in taskGroup {
                users.append(result)
            }
        }
        return users
            .compactMap { $0 }
            .sorted(by: { $0.index < $1.index })
            .map(\.user)
    }
}
