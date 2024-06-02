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
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        switch Util.shared.decodeResponse(
            response.data, keyDecodingStrategy: .useDefaultKeys
        ) as Result<World, ErrorResponse> {
        case .success(let success):
            return success
        case .failure(let errorResponse):
            throw VRCKitError.apiError(message: errorResponse.error.message)
        }
    }
}
