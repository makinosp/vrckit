//
//  InstanceModel.swift
//  
//
//  Created by makinosp on 2024/02/12.
//

public struct Instance: Codable {
    public let id: String?
    public let location: String?
    public let instanceId: String?
    public let name: String?
    public let worldId: String?
    public let type: String?
    public let ownerId: String?
    public let tags: [String]?
    public let active: Bool?
    public let full: Bool?
    public let n_users: Int?
    public let capacity: Int?

    //    public let platforms: Platform?
    public let secureName: String?
    public let shortName: String?

    //    public let clientNumber: String?

    public let photonRegion: String?
    public let region: String?

    public let canRequestInvite: Bool?
    public let permanent: Bool?
    public let strict: Bool?
}
