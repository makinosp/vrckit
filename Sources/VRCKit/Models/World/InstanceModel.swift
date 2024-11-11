//
//  InstanceModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/06/03.
//

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct Instance: Sendable, Identifiable, Hashable, Decodable {
    public let active: Bool
    public let capacity: Int
    public let full: Bool
    public let groupAccessType: GroupAccessType?
    public let id: String
    public let instanceId: String
    public let location: Location
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

    public struct Platforms: Sendable, Hashable, Codable {
        @Init(default: 0) public let android: Int
        @Init(default: 0) public let ios: Int
        @Init(default: 0) public let standalonewindows: Int
    }

    public enum GroupAccessType: String, Sendable, Codable {
        case `public`, plus
    }

    public enum Region: String, Sendable, Codable, CaseIterable {
        case us, use, eu, jp, unknown
    }

    public enum InstanceType: String, Sendable, Codable {
        case `public`, hidden, friends, `private`, group
    }
}

extension Instance: ImageUrlRepresentable {
    public func imageUrl(_ resolution: ImageResolution) -> URL? {
        switch location {
        case .offline:
            return Const.offlineImageUrl
        case .private, .traveling:
            return Const.privateWorldImageUrl
        case .id:
            guard let url = world.thumbnailImageUrl else { return nil }
            return replaceImageUrl(url: url, resolution: resolution)
        }
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

    var userPlatforms: [UserPlatform] {
        [
            platforms.android > 0 ? UserPlatform.android : nil,
            platforms.ios > 0 ? UserPlatform.ios : nil,
            platforms.standalonewindows > 0 ? UserPlatform.standalonewindows : nil
        ].compactMap { $0 }
    }
}

public extension Instance.Platforms {
    /// Initialize from an array of UserPlatform
    /// - Parameter platforms: An array of UserPlatform
    init(_ platforms: [UserPlatform]) {
        self.init(
            android: platforms.contains(.android) ? 1 : 0,
            ios: platforms.contains(.ios) ? 1 : 0,
            standalonewindows: platforms.contains(.standalonewindows) ? 1 : 0
        )
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

extension Instance.Region: CustomStringConvertible {
    public var description: String {
        switch self {
        case .eu: "EU"
        case .jp: "Japan"
        case .use: "US East"
        default: "US West"
        }
    }
}

extension Instance.InstanceType: CustomStringConvertible {
    public var description: String { rawValue }
}

extension Instance.InstanceTypeAlias: CustomStringConvertible {
    public var description: String { rawValue }
}
