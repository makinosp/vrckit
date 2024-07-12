//
//  WorldModel.swift
//
//
//  Created by makinosp on 2024/02/12.
//
import Foundation

public struct World: Codable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let description: String
    public let featured: Bool
    public let authorId: String
    public let authorName: String
    public let capacity: Int
    public let tags: [String]
    public let releaseStatus: ReleaseStatus
    public let imageUrl: String
    public let thumbnailImageUrl: String
    public let namespace: String?
    public let organization: String
    public let previewYoutubeId: String?
    public let favorites: Int
    public let createdAt: Date
    public let updatedAt: Date
    public let publicationDate: OptionalISO8601Date
    public let labsPublicationDate: OptionalISO8601Date
    public let visits: Int
    public let popularity: Int
    public let heat: Int
    // MARK: Only world info params
    // public let publicOccupants: Int
    // public let privateOccupants: Int
    public let version: Int?

    public enum ReleaseStatus: String, Codable {
        case `public`, `private`, hidden, all
    }
}
