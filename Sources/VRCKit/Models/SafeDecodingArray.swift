//
//  SafeDecodingArray.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/28.
//

import MemberwiseInit

@propertyWrapper @MemberwiseInit(.public)
public struct SafeDecodingArray<T> {
    @Init(default: []) public var wrappedValue: [T]
}

extension SafeDecodingArray: Decodable where T: Decodable {
    public init(from decoder: Decoder) throws {
        wrappedValue = []
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let value = try? container.decode(T.self) {
                wrappedValue.append(value)
            } else {
                // Skip the decorder cursor
                _ = try? container.decode(T.self)
            }
        }
    }
}

extension SafeDecodingArray: Hashable where T: Hashable {
    public static func == (lhs: SafeDecodingArray<T>, rhs: SafeDecodingArray<T>) -> Bool {
        lhs.wrappedValue.hashValue == rhs.wrappedValue.hashValue
    }
}

extension SafeDecodingArray: Encodable where T: Encodable {}
extension SafeDecodingArray: Equatable where T: Equatable {}
extension SafeDecodingArray: Sendable where T: Sendable {}
