//
//  AvatarModel.swift
//  
//
//  Created by makinosp on 2024/02/12.
//

public struct Avatar: Codable, Hashable, Identifiable {
    public let id: String?
    public let name: String?
    public let description: String?
    public let authorId: String?
    public let authorName: String?
    public let tags: [String]?
    public let imageUrl: String?
    public let thumbnailImageUrl: String?
    public let releaseStatus: String?

    public let featured: Bool?

    public let created_at: String?
    public let updated_at: String?
}
