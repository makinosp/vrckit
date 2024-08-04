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
    public let type: InstanceType
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

    public enum InstanceType: String, Codable {
        case `public`, hidden, friends, `private`, group
    }
}

public extension Instance {
    enum InstanceTypeAlias: String {
        case `public` = "Public"
        case friendsPlus = "Friends+"
        case friends = "Friends"
        case `private` = "Private"
        case group = "Group"
        case groupPlus = "Group+"
        case groupPublic = "Group Public"
    }

    var typeDescription: String {
        let instanceTypeAlias: InstanceTypeAlias = switch type {
        case .public: .public
        case .hidden: .friendsPlus
        case .friends: .friends
        case .private: .private
        case .group: groupAccessType?.typeDescription ?? .group
        }
        return instanceTypeAlias.description
    }
}

extension Instance.GroupAccessType {
    var typeDescription: Instance.InstanceTypeAlias {
        switch self {
        case .public: .groupPublic
        case .plus: .groupPlus
        }
    }
}

extension Instance.InstanceType: CustomStringConvertible {
    public var description: String { rawValue }
}

extension Instance.InstanceTypeAlias: CustomStringConvertible {
    public var description: String { rawValue }
}
