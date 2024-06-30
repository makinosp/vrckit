//
//  WorldService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: World API
//

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct WorldService {
    static let worldUrl = "\(baseUrl)/worlds"

    public static func fetchWorld(_ client: APIClient, worldID: String) async throws -> World {
        let url = URL(string: "\(worldUrl)/\(worldID)")!

        let response = try await client.request(
            url: url,
            httpMethod: .get
        )
        return try Util.shared.decode(response.data)
    }
}
