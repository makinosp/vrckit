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
    ///   - resolution: The desired image resolution as an `ImageResolution` value.
    ///     The original resolution is `.origin`.
    ///
    /// - Returns: A new URL with the last numeric component replaced by the specified resolution.
    func imageUrl(_ resolution: ImageResolution) -> URL?
}

public extension ImageUrlRepresentable {
    /// Replaces the image URL with a specified resolution if applicable.
    ///
    /// This function modifies the last path component of the given URL,
    /// changing it to the desired `ImageResolution` if the URL's current
    /// last path component is a numeric value greater than 1. If the
    /// specified resolution is `.origin` or if the URL’s last path
    /// component does not meet the numeric requirements, the function
    /// returns the original URL.
    ///
    /// - Parameters:
    ///   - url: The original image URL to be modified.
    ///   - resolution: The desired image resolution, used to replace the
    ///                 numeric component in the URL if applicable.
    ///
    /// - Returns: A new URL with the specified resolution if replacement
    ///            occurs, or the original URL if no replacement is needed.
    func replaceImageUrl(url: URL, resolution: ImageResolution) -> URL? {
        guard resolution != .origin, let number = Int(url.lastPathComponent), number > 1 else { return url }
        var urlString = url.absoluteString
        if let range = urlString.range(of: number.description, options: .backwards) {
            urlString.replaceSubrange(range, with: resolution.description)
        }
        return URL(string: urlString)
    }
}
