//
//  FavoriteWorldModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/08.
//

import Foundation

struct AnyCodable: Codable {}

public struct FavoriteWorldWrapper {
    public let worlds: [World]
}

extension FavoriteWorldWrapper: Decodable {
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var worlds: [World] = []
        while !container.isAtEnd {
            if let world = try? container.decode(World.self) {
                worlds.append(world)
            } else {
                _ = try container.decode(AnyCodable.self)
            }
        }
        self.worlds = worlds
    }
}
