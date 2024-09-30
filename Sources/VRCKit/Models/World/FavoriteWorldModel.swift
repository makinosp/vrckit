//
//  FavoriteWorldModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/08.
//

import Foundation
import MemberwiseInit

struct AnyCodable: Codable {}

public struct FavoriteWorldWrapper: Sendable {
    public let worlds: [FavoriteWorld]
}

@MemberwiseInit(.public)
public struct FavoriteWorld: Codable, Sendable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let description: String?
    public let featured: Bool
    public let authorId: String
    public let authorName: String
    public let capacity: Int
    public let tags: [String]
    public let releaseStatus: World.ReleaseStatus
    public let imageUrl: URL?
    public let thumbnailImageUrl: URL?
    public let namespace: String?
    public let organization: String
    public let previewYoutubeId: String?
    public let favorites: Int?
    public let createdAt: Date
    public let updatedAt: Date
    public let publicationDate: OptionalISO8601Date
    public let labsPublicationDate: OptionalISO8601Date
    public let visits: Int
    public let popularity: Int
    public let heat: Int
    public let favoriteGroup: String
    public let version: Int?
    public let unityPackages: [UnityPackage]
}

extension FavoriteWorldWrapper: Decodable {
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var worlds: [FavoriteWorld] = []
        while !container.isAtEnd {
            if let world = try? container.decode(FavoriteWorld.self) {
                worlds.append(world)
            } else {
                _ = try container.decode(AnyCodable.self)
            }
        }
        self.worlds = worlds
    }
}

extension FavoriteWorld: ImageUrlRepresentable {
    public func imageUrl(_ resolution: ImageResolution) -> URL? {
        guard let url = thumbnailImageUrl else { return nil }
        return replaceImageUrl(url: url, resolution: resolution)
    }
}
