//
//  PreviewDataProvider.swift
//
//
//  Created by makinosp on 2024/07/13.
//

import Foundation

final class PreviewDataProvider {
    typealias FriendSet = (friend: Friend, userDetail: UserDetail)
    static let shared = PreviewDataProvider()
    private let previewUserId = UUID()
    let friends: [Friend]
    let userDetails: [UserDetail]
    let instances: [Instance]

    private init() {
        let instance = Self.generateInstance(worldId: UUID(), instanceId: 0)
        let onlineFriendsSet: [FriendSet] = (0..<50).map { count in
            let id = UUID()
            return switch count {
            case ..<10:
                Self.generateFriendSet(id: id, location: instance.id, status: .active)
            case ..<20:
                Self.generateFriendSet(id: id, location: "private", status: .askMe)
            case ..<30:
                Self.generateFriendSet(id: id, location: instance.id, status: .joinMe)
            case ..<40:
                Self.generateFriendSet(id: id, location: "private", status: .busy)
            default:
                Self.generateFriendSet(id: id, location: "offline", status: .offline)
            }
        }
        var userDetails = onlineFriendsSet.map(\.userDetail)
        userDetails.append(PreviewDataProvider.previewUserDetail(id: previewUserId, instance: instance))

        self.userDetails = userDetails
        self.friends = onlineFriendsSet.map(\.friend)
        self.instances = [instance]
    }

    private static func previewUserDetail(id: UUID, instance: Instance) -> UserDetail {
        PreviewDataProvider.generateUserDetail(id: id, location: instance.id, state: .active, status: .active)
    }

    var onlineFriends: [Friend] {
        friends.filter { $0.status != .offline }
    }

    var offlineFriends: [Friend] {
        friends.filter { $0.status == .offline }
    }

    var previewUser: User {
        User(
            activeFriends: onlineFriends.map(\.id),
            allowAvatarCopying: false,
            bio: "This is the demo user.",
            bioLinks: ["https://example.com"],
            currentAvatar: "",
            currentAvatarAssetUrl: "",
            currentAvatarImageUrl: "",
            currentAvatarThumbnailImageUrl: "",
            dateJoined: "2024/07/01",
            displayName: "usr_\(previewUserId.uuidString.prefix(8))",
            friendKey: "",
            friends: friends.map(\.id),
            homeLocation: "",
            id: "usr_\(previewUserId.uuidString)",
            isFriend: false,
            lastActivity: Date(),
            lastLogin: Date(),
            lastPlatform: "standalonewindows",
            offlineFriends: onlineFriends.map(\.id),
            onlineFriends: offlineFriends.map(\.id),
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

    private static func generateFriendSet(
        id: UUID,
        location: String,
        status: User.Status
    ) -> FriendSet {
        (
            PreviewDataProvider.generateFriend(
                id: id,
                location: location,
                status: status
            ),
            PreviewDataProvider.generateUserDetail(
                id: id,
                location: location,
                state: status == .offline ? .offline : .active,
                status: status
            )
        )
    }

    private static func generateFriend(
        id: UUID,
        location: String,
        status: User.Status
    ) -> Friend {
        Friend(
            bio: nil,
            bioLinks: nil,
            currentAvatarImageUrl: nil,
            currentAvatarThumbnailImageUrl: nil,
            displayName: "User_\(id.uuidString.prefix(8))",
            id: "usr_\(id.uuidString)",
            isFriend: true,
            lastLogin: Date(),
            lastPlatform: "standalonewindows",
            profilePicOverride: nil,
            status: status,
            statusDescription: "",
            tags: [],
            userIcon: "https://ul.h3z.jp/9gGIcerr.png",
            location: location,
            friendKey: ""
        )
    }

    private static func generateUserDetail(
        id: UUID,
        location: String,
        state: User.State,
        status: User.Status
    ) -> UserDetail {
        UserDetail(
            bio: "Demo",
            bioLinks: [],
            currentAvatarImageUrl: nil,
            currentAvatarThumbnailImageUrl: nil,
            displayName: "User_\(id.uuidString.prefix(8))",
            id: "usr_\(id.uuidString)",
            isFriend: true,
            lastLogin: Date(),
            lastPlatform: "standalonewindows",
            profilePicOverride: nil,
            state: state,
            status: status,
            statusDescription: "Demo",
            tags: [],
            userIcon: "https://ul.h3z.jp/9gGIcerr.png",
            location: location,
            friendKey: "",
            dateJoined: "",
            note: "",
            lastActivity: Date()
        )
    }

    private static func generateInstance(worldId: UUID, instanceId: Int) -> Instance {
        Instance(
            active: true,
            capacity: 32,
            full: false,
            id: "wrld_\(worldId):\(instanceId)",
            instanceId: instanceId.description,
            location: "wrld_\(worldId.uuidString)",
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

    private static func generateWorld(worldId: UUID) -> World {
        World(
            id: "wrld_\(worldId.uuidString)",
            name: "DummyWorld",
            description: "This is Dummy World.",
            featured: true,
            authorId: "usr_\(UUID().uuidString)",
            authorName: "Dummy Author",
            capacity: 32,
            tags: [],
            releaseStatus: .public,
            imageUrl: "https://ul.h3z.jp/ecWPM0Wk.jpg",
            thumbnailImageUrl: "https://ul.h3z.jp/ecWPM0Wk.jpg",
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
