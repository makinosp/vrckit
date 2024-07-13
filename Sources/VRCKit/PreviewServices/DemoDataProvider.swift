//
//  DemoDataProvider.swift
//
//
//  Created by makinosp on 2024/07/13.
//

import Foundation

class DemoDataProvider {
    static let shared = DemoDataProvider()
    let onlineFriends: [Friend]
    let instances: [Instance]

    private init() {
        let instances = [
            DemoDataProvider.generateInstance(
                worldId: Int.random(in: 0..<99999).description,
                instanceId: "wrld_\(UUID().uuidString)"
            )
        ]
        self.instances = instances
        onlineFriends = (0..<50).map { number in
            switch number {
            case ..<10:
                DemoDataProvider.generateFriend(id: "usr_\(UUID().uuidString)", location: instances[0].id)
            default:
                DemoDataProvider.generateFriend(id: "usr_\(UUID().uuidString)", location: "private")
            }
        }
    }

    func getDemoUesr() -> User {
        User(
            activeFriends: [],
            allowAvatarCopying: false,
            bio: "This is the demo user.",
            bioLinks: ["https://example.com"],
            currentAvatar: "",
            currentAvatarAssetUrl: "",
            currentAvatarImageUrl: "",
            currentAvatarThumbnailImageUrl: "",
            dateJoined: "2024/07/01",
            displayName: "Demo user",
            friendKey: "",
            friends: [],
            homeLocation: "",
            id: "usr_\(UUID().uuidString)",
            isFriend: false,
            lastActivity: Date(),
            lastLogin: Date(),
            lastPlatform: "standalonewindows",
            offlineFriends: onlineFriends.map(\.id),
            onlineFriends: [],
            pastDisplayNames: [],
            profilePicOverride: nil,
            state: .active,
            status: .active,
            statusDescription: "status",
            tags: [],
            twoFactorAuthEnabled: true,
            userIcon: "https://ul.h3z.jp/9gGIcerr.png",
            userLanguage: nil,
            userLanguageCode: nil
        )
    }

    static func generateFriend(id: String, location: String) -> Friend {
        Friend(
            bio: nil,
            bioLinks: nil,
            currentAvatarImageUrl: nil,
            currentAvatarThumbnailImageUrl: nil,
            displayName: "Dummy friend",
            id: id,
            isFriend: true,
            lastLogin: Date(),
            lastPlatform: "standalonewindows",
            profilePicOverride: nil,
            status: .active,
            statusDescription: "",
            tags: [],
            userIcon: "https://ul.h3z.jp/9gGIcerr.png",
            location: location,
            friendKey: ""
        )
    }

    static func generateInstance(fullId: String) -> Instance {
        let ids = fullId.split(separator: ":")
        return generateInstance(worldId: String(ids[0]), instanceId: String(ids[1]))
    }

    static func generateInstance(worldId: String, instanceId: String) -> Instance {
        Instance(
            active: true,
            capacity: 32,
            full: false,
            id: "\(worldId):\(instanceId)",
            instanceId: instanceId,
            location: worldId,
            name: "DummyInstance_\(instanceId)",
            ownerId: "usr_\(UUID().uuidString)",
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
            world: generateWorld(worldId: worldId)
        )
    }

    static func generateWorld(worldId: String) -> World {
        World(
            id: worldId,
            name: "DummyWorld",
            description: "This is Dummy World.",
            featured: true,
            authorId: "usr_\(UUID().uuidString)",
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
    }
}
