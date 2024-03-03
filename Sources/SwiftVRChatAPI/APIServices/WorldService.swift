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

let worldUrl = "\(baseUrl)/worlds"

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct WorldService {

    public static func getWorld(client: APIClientAsync, worldID: String) async throws -> World? {
        let url = URL(string: "\(worldUrl)/\(worldID)")!
        
        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            apiKey: true
        )

        let world: World? =  try JSONDecoder().decode(World?.self, from: responseData)
        return world
    }
}
