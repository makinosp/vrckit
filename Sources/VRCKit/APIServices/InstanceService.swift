//
//  InstanceService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: Instance API
//

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct InstanceService {
    static let instanceUrl = "\(baseUrl)/instances"

    public static func fetchInstance(
        _ client: APIClient,
        worldID: String,
        instanceID: String
    ) async throws -> Instance {
        let url = URL(string: "\(instanceUrl)/\(worldID):\(instanceID)")!
        
        let response = try await client.request(
            url: url,
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        switch Util.shared.decodeResponse(
            response.data
        ) as Result<Instance, ErrorResponse> {
        case .success(let success):
            return success
        case .failure(let errorResponse):
            throw VRCKitError.apiError(errorResponse.error.message)
        }
    }

    public static func fetchInstance(
        _ client: APIClient,
        location: String
    ) async throws -> Instance {
        let url = URL(string: "\(instanceUrl)/\(location)")!

        let response = try await client.request(
            url: url,
            httpMethod: .get,
            cookieKeys: [.auth, .apiKey]
        )
        switch Util.shared.decodeResponse(
            response.data,
            keyDecodingStrategy: .useDefaultKeys
        ) as Result<Instance, ErrorResponse> {
        case .success(let success):
            return success
        case .failure(let errorResponse):
            throw VRCKitError.apiError(errorResponse.error.message)
        }
    }
}
