//
//  APIService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

protocol APIService {
    var client: APIClient { get }
    init(client: APIClient)
}
