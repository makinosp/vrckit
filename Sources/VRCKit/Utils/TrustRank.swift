//
//  TrustRank.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

public enum TrustRank: Equatable {
    case trusted, known, user, newUser, visitor, unknown
}

public extension ProfileElementRepresentable {
    var trustRank: TrustRank {
        let rankTags: [SystemTag] = [
            .systemTrustVeteran,
            .systemTrustTrusted,
            .systemTrustKnown,
            .systemTrustBasic
        ]
        let rankTag = rankTags.first { tags.systemTags.contains($0) }
        guard let rankTag = rankTag else { return .visitor }
        return switch rankTag {
        case .systemTrustVeteran: .trusted
        case .systemTrustTrusted: .known
        case .systemTrustKnown: .user
        case .systemTrustBasic: .newUser
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
