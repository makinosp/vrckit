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

@MemberwiseInit
struct RequestToUpdateFavoriteGroup: Codable, Sendable {
    let displayName: String?
    let visibility: FavoriteGroup.Visibility?
    @Init(default: []) let tags: [String]
}

@MemberwiseInit(.public)
public struct FavoriteGroupParams: Sendable {
    let type: FavoriteType
    let name: String
    let userId: String
}
