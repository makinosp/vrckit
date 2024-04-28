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
    typealias UserWithIndex = (index: Int, user: UserDetail)
    typealias FetchUserResponse = (index: Int, response: Result<UserDetail, ErrorResponse>)

    static let userUrl = "\(baseUrl)/users"

    /// Fetch a user
    public static func fetchUser(
        _ client: APIClient,
        userId: String
    ) async throws -> Result<UserDetail, ErrorResponse> {
        let url = URL(string: "\(userUrl)/\(userId)")!
        let response = try await client.request(
            url: url,
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        return Util.shared.decodeResponse(response.data)
    }

    /// Fetch uesrs
    public static func fetchUsers(
        _ client: APIClient,
        userIds: [String]
    ) async throws -> Result<[UserDetail], ErrorResponse> {
        var users: [UserWithIndex] = []
        try await withThrowingTaskGroup(of: FetchUserResponse.self) { taskGroup in
            for (index, userId) in userIds.enumerated() {
                taskGroup.addTask {
                    try await (
                        index: index,
                        response: UserService.fetchUser(client, userId: userId)
                    )
                }
            }
            for try await result in taskGroup {
                switch result.response {
                    case .success(let user):
                        users.append(UserWithIndex(index: result.index, user: user))
                    case .failure(_):
                        continue
                }
            }
        }
        return .success(users.sorted(by: { $0.index < $1.index }).map(\.user))
    }

//    public static func updateUser(
//        client: APIClient,
//        userID: String,
//        statusDescription: String? = nil,
//        tags: [String]? = nil,
//        bio: String? = nil,
//        bioLinks: [String]? = nil
//    ) async throws -> User? {
//        let url = URL(string: "\(userUrl)/\(userID)")!
//        
//        var userInfo: [String: Any] = [:]
//        
//        if let statusDescription = statusDescription {
//            userInfo["statusDescription"] = statusDescription
//        }
//        
//        if let tags = tags {
//            userInfo["tags"] = tags
//        }
//        
//        if let bio = bio {
//            userInfo["bio"] = bio
//        }
//        
//        if let bioLinks = bioLinks {
//            userInfo["bioLinks"] = bioLinks
//        }
//        
//        let httpBody: Data?
//        do {
//            httpBody = try JSONSerialization.data(withJSONObject: userInfo)
//        } catch let error {
//            print(error.localizedDescription)
//            return nil
//        }
//        
//        let (responseData, _) = try await client.request(
//            url: url,
//            httpMethod: .put,
//            auth: true,
//            apiKey: true,
//            contentType: .json,
//            httpBody: httpBody
//        )
//        
//        let user: User? = try JSONDecoder().decode(User?.self, from: responseData)
//        return user
//    }
}
