//
//  SafeDecodingArray.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/28.
//

import Foundation

public struct SafeDecodingArray<Element: Codable & Hashable> {
    public let elements: [Element]
}

extension SafeDecodingArray {
    init() {
        elements = []
    }
}

extension SafeDecodingArray: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        elements = (try? container.decode([Element].self)) ?? []
    }
}

extension SafeDecodingArray: Hashable {
    public static func == (lhs: SafeDecodingArray<Element>, rhs: SafeDecodingArray<Element>) -> Bool {
        lhs == rhs
    }
}
