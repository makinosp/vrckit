//
//  ImageUrlRepresentableProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

import Foundation

public protocol ImageUrlRepresentable: Sendable {
    func imageUrl(_ resolution: ImageResolution) -> URL?
}

public extension ImageUrlRepresentable {
    func replaceImageUrl(url: URL, resolution: ImageResolution) -> URL? {
        guard resolution != .origin, let number = Int(url.lastPathComponent), number > 1 else { return url }
        var urlString = url.absoluteString
        if let range = urlString.range(of: number.description, options: .backwards) {
            urlString.replaceSubrange(range, with: resolution.description)
        }
        return URL(string: urlString)
    }
}
