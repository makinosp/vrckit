//
//  ProfileImageURL.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

import Foundation

public extension ProfileElementRepresentable {
    var thumbnailUrl: URL? {
        if let userIcon = userIcon { return userIcon }
        guard let url = avatarThumbnailUrl else { return nil }
        var urlString = url.absoluteString
        if urlString.hasSuffix("256") {
            urlString = String(urlString.dropLast(3)) + "1024"
        }
        return URL(string: urlString)
    }
}
