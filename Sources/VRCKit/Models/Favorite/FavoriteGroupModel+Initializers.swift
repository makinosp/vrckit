//
//  FavoriteGroupModel+Initializers.swift
//  VRCKit
//
//  Created by makinosp on 2024/10/12.
//

public extension FavoriteGroup {
    /// Initialize by updatable values
    init(source: FavoriteGroup, displayName: String, visibility: Visibility) {
        self.init(
            id: source.id,
            displayName: displayName,
            name: source.name,
            ownerId: source.ownerId,
            tags: source.tags,
            type: source.type,
            visibility: visibility
        )
    }
}
