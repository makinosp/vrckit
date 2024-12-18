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
    public let createdAt: OptionalISO8601Date
    public let updatedAt: OptionalISO8601Date
    public let publicationDate: OptionalISO8601Date
    public let labsPublicationDate: OptionalISO8601Date
    public let visits: Int
    public let popularity: Int
    public let heat: Int
    public let version: Int?
    public let unityPackages: [UnityPackage]
    public let occupants: Int?
    public let privateOccupants: Int?
    public let publicOccupants: Int?

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

public extension World {
    enum Platform: Hashable {
        case android, crossPlatform, windows, none
    }

    var platform: Platform {
        let platforms = Set(unityPackages.map(\.platform))
        return if platforms.isSuperset(of: [.standalonewindows, .android]) {
            .crossPlatform
        } else if platforms.contains(.standalonewindows) {
            .windows
        } else if platforms.contains(.android) {
            .android
        } else {
            .none
        }
    }
}

extension World.Platform: CustomStringConvertible {
    public var description: String {
        switch self {
        case .android: "Quest Only"
        case .crossPlatform: "Cross-Platform"
        case .windows: "PC Only"
        case .none: "None"
        }
    }
}

extension World: ImageUrlRepresentable {
    public func imageUrl(_ resolution: ImageResolution) -> URL? {
        guard let url = thumbnailImageUrl else { return nil }
        return replaceImageUrl(url: url, resolution: resolution)
    }
}
