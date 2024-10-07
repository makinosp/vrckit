//
//  FavoriteModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/10/06.
//

import MemberwiseInit

@MemberwiseInit(.public)
public struct FavoriteGroup: Codable, Sendable, Identifiable, Hashable {
    public let id: String
    public let displayName: String
    public let name: String
    public let ownerId: String
    public let tags: [String]
    public let type: FavoriteType
    public let visibility: Visibility

    public enum Visibility: String, Codable, Sendable {
        case `private`, friends, `public`
    }
}

public extension FavoriteGroup {
    /// Initialize by updatable values
    init(source: FavoriteGroup, displayName: String, visibility: Visibility) {
        self.init(
            id: source.id,
            displayName: displayName,
            name: source.name,
            ownerId: source.ownerId,
            tags: source.tags,
            type: source.type,
            visibility: visibility
        )
    }
}

@MemberwiseInit
struct RequestToUpdateFavoriteGroup: Codable, Sendable {
    let displayName: String?
    let visibility: FavoriteGroup.Visibility?
    @Init(default: []) let tags: [String]
}
