//
//  ProfileElementRepresentable+thumbnailUrl.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

import Foundation

public extension ProfileElementRepresentable {
    func imageUrl(_ resolution: ImageResolution) -> URL? {
        guard let url = userIcon ?? avatarThumbnailUrl else { return nil }
        return replaceImageUrl(url: url, resolution: resolution)
    }

    private func replaceImageUrl(url: URL, resolution: ImageResolution) -> URL? {
        guard resolution != .origin, Int(url.lastPathComponent) != nil else { return url }
        var urlString = url.absoluteString
        if let range = urlString.range(of: url.lastPathComponent, options: .backwards) {
            urlString.replaceSubrange(range, with: resolution.description)
        }
        return URL(string: urlString)
    }
}
