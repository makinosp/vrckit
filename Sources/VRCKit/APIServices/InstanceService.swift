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

//public struct InstanceAPI {
//    
//    static let instanceUrl = "\(baseUrl)/instances"
//
//    public static func getInstance(
//        client: APIClient,
//        worldID: String,
//        instanceID: String,
//        completionHandler: @escaping @Sendable (Instance?) -> Void
//    ) {
//        let url = URL(string: "\(instanceUrl)/\(worldID):\(instanceID)")!
//        
//        client.request(
//            url: url,
//            httpMethod: .get,
//            auth: true,
//            apiKey: true
//        ) { data, _, error in
//            guard let data = data, error == nil else { return }
//
//            let instance: Instance? = decode(data: data)
//            
//            completionHandler(instance)
//        }
//    }
//}
