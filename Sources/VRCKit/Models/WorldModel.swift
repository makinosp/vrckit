//
//  WorldModel.swift
//
//
//  Created by makinosp on 2024/02/12.
//

public struct World: Codable, Identifiable, Hashable {
    public let id: String?
    public let name: String?
    public let description: String?
    public let featured: Bool?
    public let authorId: String?
    public let authorName: String?

    public let capacity: Int?
    public let tags: [String]?
    public let releaseStatus: String?
    public let imageUrl: String?
    public let thumbnailImageUrl: String?
    public let namespace: String?

    public let version: Int?

    public let organization: String?
    public let previewYoutubeId: String?
    public let favorites: Int?
    public let created_at: String?
    public let updated_at: String?
    public let publicationDate: String?
    public let labsPublicationDate: String?
    public let visits: Int?
    public let popularity: Int?
    public let heat: Int?
    public let publicOccupants: Int?
    public let privateOccupants: Int?

    //    public let instances: [(Any)]?
}
