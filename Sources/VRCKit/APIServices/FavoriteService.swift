//
//  FavoriteService.swift
//
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: Favorite API
//

let favoriteUrl = "\(baseUrl)/favorites"

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct FavoriteAPIAsync {

    public static func getFavorites(
        client: APIClientAsync,
        n: Int = 60
    ) async throws -> [Favorite]? {
        var request = URLComponents(string: favoriteUrl)!
        request.queryItems = [URLQueryItem(name: "n", value: n.description)]
        guard let url = request.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(favoriteUrl)"])
        }
        
        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            auth: true,
            apiKey: true
        )
        let favorites: [Favorite]? = try JSONDecoder().decode([Favorite].self, from: responseData)
        return favorites
    }
    
    public static func addFavorite(
        client: APIClientAsync,
        type: FavoriteType = .friend,
        favoriteId: String,
        tags: [String]? = nil
    ) async throws -> Favorite? {
        let url = URL(string: "\(favoriteUrl)")!
        
        var favoriteInfo: [String: Any] = [:]
        
        favoriteInfo["type"] = type.rawValue
        favoriteInfo["favoriteId"] = favoriteId
        
        if tags == nil {
            switch type {
            case .world:
                favoriteInfo["tags"] = ["worlds1"]
            case .avatar:
                favoriteInfo["tags"] = ["avatars1"]
            case .friend:
                favoriteInfo["tags"] = ["group_0"]
            }
        } else {
            favoriteInfo["tags"] = tags
        }
        
        var httpBody: Data
        
        do {
            httpBody = try JSONSerialization.data(withJSONObject: favoriteInfo)
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .post,
            auth: true,
            apiKey: true,
            contentType: .json,
            httpBody: httpBody
        )
        let favorite: Favorite? = try JSONDecoder().decode(Favorite?.self, from: responseData)
        return favorite
    }
    
    public static func removeFavorite(
        client: APIClientAsync,
        favoriteId: String
    ) async throws -> Favorite? {
        let url = URL(string: "\(favoriteUrl)/\(favoriteId)")!
        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .delete,
            auth: true,
            apiKey: true
        )
        
        let favorite: Favorite? = try JSONDecoder().decode(Favorite?.self, from: responseData)
        return favorite
    }
}
