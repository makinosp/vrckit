//
//  SafeDecodingArray.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/28.
//

@propertyWrapper
public struct SafeDecodingArray<T> {
    public var wrappedValue: [T]

    public init(wrappedValue: [T] = []) {
        self.wrappedValue = wrappedValue
    }
}

extension SafeDecodingArray: Decodable where T: Decodable {
    private struct AnyDecodable: Decodable {}
    public init(from decoder: Decoder) throws {
        wrappedValue = []
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let value = try? container.decode(T.self) {
                wrappedValue.append(value)
            } else {
                _ = try container.decode(AnyDecodable.self)
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
