//
//  AvatarService.swift
//  
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: World API
//

//public struct AvatarAPI {
//    static let avatarUrl = "\(baseUrl)/avatars"
//
//    public static func searchAvatar(
//        client: APIClient,
//        featured: Bool = true,
//        n: Int = 60,
//        completionHandler: @escaping @Sendable ([Avatar]?) -> Void
//    ) {
//        
//        let url = URL(string: "\(avatarUrl)?featured=\(featured)&n=\(n)")!
//        
//        client.VRChatRequest(
//            url: url,
//            httpMethod: .get,
//            auth: true,
//            apiKey: true
//        ) { data, _, error in
//            guard let data = data, error == nil else { return }
//
//            let avatars: [Avatar]? = decode(data: data)
//            
//            completionHandler(avatars)
//        }
//    }
//    
//    public static func getFavoritedAvatar(
//        client: APIClient,
//        featured: Bool = true,
//        n: Int = 60,
//        completionHandler: @escaping @Sendable ([Avatar]?) -> Void
//    ) {
//        
//        let url = URL(string: "\(avatarUrl)/favorites")!
//        
//        client.VRChatRequest(
//            url: url,
//            httpMethod: .get,
//            auth: true,
//            apiKey: true
//        ) { data, _, error in
//            guard let data = data, error == nil else { return }
//
//            let avatars: [Avatar]? = decode(data: data)
//            
//            completionHandler(avatars)
//        }
//    }
//}
