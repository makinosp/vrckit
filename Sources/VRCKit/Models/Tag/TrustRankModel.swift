//
//  TrustRankModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

public enum TrustRank: Equatable, Sendable {
    case trusted, known, user, newUser, visitor, unknown
}

public extension ProfileElementRepresentable {
    var systemTag: SystemTag? {
        SystemTag.rankTags.first { tags.systemTags.contains($0) }
    }
    var trustRank: TrustRank {
        switch systemTag {
        case .systemTrustVeteran: .trusted
        case .systemTrustTrusted: .known
        case .systemTrustKnown: .user
        case .systemTrustBasic: .newUser
        case nil: .visitor
        default: .unknown
        }
    }
}

extension TrustRank: CustomStringConvertible {
    public var description: String {
        switch self {
        case .trusted: "Trusted"
        case .known: "Known"
        case .user: "User"
        case .newUser: "New User"
        case .visitor: "Visitor"
        case .unknown: "Unknown"
        }
    }
}
