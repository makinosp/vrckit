//
//  SafeDecoding.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/30.
//

@propertyWrapper
public struct SafeDecoding<T> {
    public var wrappedValue: T?

    public init(wrappedValue: T? = nil) {
        self.wrappedValue = wrappedValue
    }
}

extension SafeDecoding: Decodable where T: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try? container.decode(T.self)
    }
}

extension SafeDecoding: Identifiable where T: Identifiable {
    public var id: T.ID? { wrappedValue?.id }
}

extension SafeDecoding: Encodable where T: Encodable {}
extension SafeDecoding: Equatable where T: Equatable {}
extension SafeDecoding: Hashable where T: Hashable {}
extension SafeDecoding: Sendable where T: Sendable {}
