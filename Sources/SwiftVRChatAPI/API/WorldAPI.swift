//
//  WorldAPI.swift
//  
//
//  Created by 夏同光 on 2/24/23.
//

import Foundation

public struct World: Codable {
    public let id: String?
    public let name: String?
    public let description: String?
    public let featured: Bool?
    public let authorId: String?
    public let authorName: String?
    
    public let capacity: Int?
    public let tags: [String]?
    public let releaseStatus: String?
    public let imageUrl: String?
    public let thumbnailImageUrl: String?
    public let namespace: String?
    
//    public let unityPackages: [UnityPackage]
    
    public let version: Int?
    
    public let organization: String?
    public let previewYoutubeId: String?
    public let favorites: Int?
    public let created_at: String?
    public let updated_at: String?
    public let publicationDate: String?
    public let labsPublicationDate: String?
    public let visits: Int?
    public let popularity: Int?
    public let heat: Int?
    public let publicOccupants: Int?
    public let privateOccupants: Int?
    
//    public let instances: [(Any)]?
}

//
// MARK: World API
//

let worldUrl = "\(baseUrl)/worlds"

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct WorldAPIAsync {

    public static func getWorld(client: APIClientAsync, worldID: String) async -> World? {
        let url = URL(string: "\(worldUrl)/\(worldID)")!
        
        let (data, _) = await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            apiKey: true
        )

        guard let data = data else { return nil }

        let world: World? = decode(data: data)
        
        return world
    }
}

public struct WorldAPI {

    public static func getWorld(
        client: APIClient,
        worldID: String,
        completionHandler: @escaping @Sendable (World?) -> Void
    ) {
        let url = URL(string: "\(worldUrl)/\(worldID)")!
        
        client.VRChatRequest(
            url: url,
            httpMethod: .get,
            apiKey: true
        ) { data, _, error in
            guard let data = data, error == nil else { return }

            let world: World? = decode(data: data)
            
            completionHandler(world)
        }
    }
    
    public static func searchWorld(
        client: APIClient,
        // featured: Bool = true,
        // n: Int = 60,
        completionHandler: @escaping @Sendable ([World]?) -> Void
    ) {
        
        let url = URL(string: "\(worldUrl)")!
//        let url = URL(string: "\(avatarUrl)?featured=\(featured)&n=\(n)")!
        
        client.VRChatRequest(
            url: url,
            httpMethod: .get,
            auth: true,
            apiKey: true
        ) { data, _, error in
            guard let data = data, error == nil else { return }

            let worlds: [World]? = decode(data: data)
            
            completionHandler(worlds)
        }
    }
    
    public static func getFavoritedWorld(
        client: APIClient,
        completionHandler: @escaping @Sendable ([World]?) -> Void
    ) {
        let url = URL(string: "\(worldUrl)/favorites")!
        
        client.VRChatRequest(
            url: url,
            httpMethod: .get,
            auth: true,
            apiKey: true
        ) { data, _, error in
            guard let data = data, error == nil else { return }

            let worlds: [World]? = decode(data: data)
            
            completionHandler(worlds)
        }
    }
}
