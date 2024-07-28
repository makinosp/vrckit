//
//  NullableArray.swift
//
//
//  Created by makinosp on 2024/07/28.
//

import Foundation

@propertyWrapper
public struct NullableArray<T: Codable & Hashable> {
    public let wrappedValue: [T]
    public init(wrappedValue: [T]) {
        self.wrappedValue = wrappedValue
    }
}

extension NullableArray: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            wrappedValue = []
        } else {
            wrappedValue = try container.decode([T].self)
        }
    }
}

extension NullableArray: Hashable {
    public static func == (lhs: NullableArray<T>, rhs: NullableArray<T>) -> Bool {
        lhs == rhs
    }
}
