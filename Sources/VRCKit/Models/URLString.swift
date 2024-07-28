//
//  URLString.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/28.
//

import Foundation

public struct URLString: Codable, Hashable {
    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let urlString = try container.decode(String.self)
        guard let url = URL(string: urlString) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid URL string.")
        }
        self.url = url
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(url.absoluteString)
    }
}
