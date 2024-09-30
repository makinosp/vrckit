//
//  SafeDecoding.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/30.
//

import Foundation

@propertyWrapper
public struct SafeDecoding<T>: Codable, Sendable where T: Codable & Sendable {
    public var wrappedValue: T?

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try? container.decode(T.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
