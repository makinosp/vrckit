//
//  FavoriteModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/10/06.
//

public enum FavoriteType: String, Codable, Sendable, CaseIterable {
    case world, avatar, friend
}

extension FavoriteType: Identifiable {
    public var id: String { rawValue }
}
