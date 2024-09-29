//
//  WorldModel+Initializers.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/28.
//

public extension World {
    /// Initializer from `FavoriteWorld` model. 
    init(world: FavoriteWorld) {
        self.init(
            id: world.id,
            name: world.name,
            description: world.description,
            featured: world.featured,
            authorId: world.authorId,
            authorName: world.authorName,
            capacity: world.capacity,
            tags: world.tags,
            releaseStatus: world.releaseStatus,
            imageUrl: world.imageUrl,
            thumbnailImageUrl: world.thumbnailImageUrl,
            namespace: world.namespace,
            organization: world.organization,
            previewYoutubeId: world.previewYoutubeId,
            favorites: world.favorites,
            createdAt: world.createdAt,
            updatedAt: world.updatedAt,
            publicationDate: world.publicationDate,
            labsPublicationDate: world.labsPublicationDate,
            visits: world.visits,
            popularity: world.popularity,
            heat: world.heat,
            version: world.version,
            unityPackages: world.unityPackages
        )
    }
}
