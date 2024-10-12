//
//  PresenceModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/10/12.
//

import MemberwiseInit

@MemberwiseInit(.public)
public struct Presence: Codable, Hashable, Sendable {
    public let groups: [String]
    public let id: String
    public let instance: String
    public let instanceType: String
    public let platform: UserPlatform
    public let status: UserStatus
    public let travelingToInstance: String
    public let travelingToWorld: String
    public let world: String
}
