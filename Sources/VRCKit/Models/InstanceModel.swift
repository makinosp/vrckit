//
//  InstanceModel.swift
//
//
//  Created by makinosp on 2024/06/03.
//

public struct Instance: Identifiable, Hashable, Codable {
    public let active: Bool
    public let capacity: Int
    public let full: Bool
    public let id: String
    public let instanceId: String
    public let location: String
    public let name: String
    public let ownerId: String?
    public let permanent: Bool
    public let platforms: Platforms
    public let recommendedCapacity: Int
    public let region: Region
    public let tags: [String]
    public let type: WorldType
    public let userCount: Int
    public let world: World

    public struct Platforms: Hashable, Codable {
        public let android: Int
        public let ios: Int
        public let standalonewindows: Int
    }

    public enum Region: String, Codable {
        case us
        case use
        case eu
        case jp
    }

    public enum WorldType: String, Codable {
        case `public`
        case hidden
        case friends
        case `private`
        case group
    }

    public struct World: Identifiable, Hashable {
        public let id: String
        public let name: String
        public let description: String
        public let featured: Bool
        public let authorId: String
        public let authorName: String

        public let capacity: Int
        public let tags: [String]
        public let releaseStatus: String
        public let imageUrl: String
        public let thumbnailImageUrl: String
        public let namespace: String?

        public let version: Int?

        public let organization: String
        public let previewYoutubeId: String?
        public let favorites: Int
        public let createdAt: String
        public let updatedAt: String
        public let publicationDate: String
        public let labsPublicationDate: String
        public let visits: Int
        public let popularity: Int
        public let heat: Int
    }
}

extension Instance.World: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case featured
        case authorId
        case authorName
        case capacity
        case tags
        case releaseStatus
        case imageUrl
        case thumbnailImageUrl
        case namespace
        case version
        case organization
        case previewYoutubeId
        case favorites
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case publicationDate
        case labsPublicationDate
        case visits
        case popularity
        case heat
    }
}
