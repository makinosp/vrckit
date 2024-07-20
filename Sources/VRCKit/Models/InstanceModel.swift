//
//  InstanceModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/06/03.
//

public struct Instance: Identifiable, Hashable, Codable {
    public let active: Bool
    public let capacity: Int
    public let full: Bool
    public let groupAccessType: GroupAccessType?
    public let id: String
    public let instanceId: String
    public let location: String
    public let name: String
    public let ownerId: String?
    public let permanent: Bool
    public let platforms: Platforms
    public let recommendedCapacity: Int
    public let region: Region
    public let tags: [String]
    public let type: WorldType
    public let userCount: Int
    public let world: World

    public struct Platforms: Hashable, Codable {
        public let android: Int
        public let ios: Int
        public let standalonewindows: Int
    }

    public enum GroupAccessType: String, Codable {
        case `public`, plus
    }

    public enum Region: String, Codable {
        case us, use, eu, jp, unknown
    }

    public enum WorldType: String, Codable {
        case `public`
        case hidden
        case friends
        case `private`
        case group
    }

    public enum InstanceType: String, CustomStringConvertible {
        case `public` = "Public"
        case friendsPlus = "Friends+"
        case friends = "Friends"
        case `private` = "Private"
        case group = "Group"
        case groupPlus = "Group+"
        case groupPublic = "Group Public"

        public var description: String {
            rawValue
        }
    }

    public var instanceType: InstanceType {
        switch self.type {
        case .public: .public
        case .hidden: .friendsPlus
        case .friends: .friends
        case .private: .private
        case .group:
            switch self.groupAccessType {
            case .plus: .groupPlus
            case .public: .groupPublic
            default: .group
            }
        }
    }
}
