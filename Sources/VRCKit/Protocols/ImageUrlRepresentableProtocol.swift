//
//  ImageUrlRepresentableProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

import Foundation

public protocol ImageUrlRepresentable: Sendable {
    /// Replaces the last numeric component in the provided image URL with a specified resolution and returns a new URL.
    ///
    /// - Parameters:
    ///   - url: The original image URL to modify.
    ///   - resolution: The desired image resolution as an `ImageResolution` value. The original resolution is `.origin`.
    ///
    /// - Returns: A new URL with the last numeric component replaced by the specified resolution.
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
