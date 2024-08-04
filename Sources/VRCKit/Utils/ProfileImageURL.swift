//
//  ProfileImageURL.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

import Foundation

public extension ProfileElementRepresentable {
    var thumbnailUrl: URL? {
        if let userIcon = userIcon {
            return userIcon
        }
        guard let url = avatarThumbnailUrl,
              let urlString = url.absoluteString.hasSuffix("256")
                ? String(url.absoluteString.dropLast(3)) + "512"
                : avatarImageUrl?.absoluteString else { return nil }
        return URL(string: urlString)
    }

    var userIconUrl: URL? {
        if let userIcon = userIcon {
            return userIcon
        }
        return avatarThumbnailUrl
    }
}
