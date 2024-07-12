//
//  InstancePreviewService.swift
//
//
//  Created by makinosp on 2024/07/09.
//

import Foundation

public class InstancePreviewService: InstanceService {
    override public func fetchInstance(
        worldId: String,
        instanceId: String
    ) async throws -> Instance {
        let instanceId = Int.random(in: 0..<99999).description
        let worldId = "wrld_\(UUID().uuidString)"
        let fullId = "\(worldId):\(instanceId)"
        let userId = "usr_\(UUID().uuidString)"
        return Instance(
            active: true,
            capacity: 32,
            full: false,
            id: fullId,
            instanceId: instanceId,
            location: worldId,
            name: "DummyInstance_\(instanceId)",
            ownerId: userId,
            permanent: false,
            platforms: Instance.Platforms(
                android: 0,
                ios: 0,
                standalonewindows: 0
            ),
            recommendedCapacity: 32,
            region: .jp,
            tags: [],
            type: .public,
            userCount: 0,
            world: World(
                id: worldId,
                name: "DummyWorld",
                description: "This is Dummy World.",
                featured: true,
                authorId: userId,
                authorName: "Dummy Author",
                capacity: 32,
                tags: [],
                releaseStatus: .public,
                imageUrl: "",
                thumbnailImageUrl: "",
                namespace: nil,
                organization: "",
                previewYoutubeId: "",
                favorites: 1,
                createdAt: Date(),
                updatedAt: Date(),
                publicationDate: OptionalISO8601Date(),
                labsPublicationDate: OptionalISO8601Date(),
                visits: 1,
                popularity: 1,
                heat: 1,
                version: 1
            )
        )
    }
}
