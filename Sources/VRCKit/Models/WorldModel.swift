//
//  WorldModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/12.
//

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct World: Codable, Sendable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let description: String?
    public let featured: Bool
    public let authorId: String
    public let authorName: String
    public let capacity: Int
    public let tags: [String]
    public let releaseStatus: ReleaseStatus
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
    public let favoriteGroup: String?
    public let version: Int?

    public enum ReleaseStatus: String, Codable, Sendable {
        case `public`, `private`, hidden, all
    }
}

public extension World {
    var url: URL? {
        var urlComponents = URLComponents(string: "\(Const.homeBaseUrl)/launch")
        urlComponents?.queryItems = [URLQueryItem(name: "worldId", value: id)]
        return urlComponents?.url
    }
}

extension World: ImageUrlRepresentable {
    public func imageUrl(_ resolution: ImageResolution) -> URL? {
        guard let url = thumbnailImageUrl else { return nil }
        return replaceImageUrl(url: url, resolution: resolution)
    }
}
