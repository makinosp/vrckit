//
//  KeyedDecodingContainer+decodeSafeNullableArray.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/02.
//

import Foundation

public extension KeyedDecodingContainer {
    /// Decodes an array for the specified key and returns it. If the decoding fails, it returns an empty array.
    ///
    /// This method attempts to decode a `SafeDecodingArray` from the container for the specified key. If the key is not
    /// present or if the decoding fails, it returns an empty `SafeDecodingArray`.
    ///
    /// - Parameters:
    ///   - type: The type of elements in the array to decode.
    ///   - key: The key that the decoded value is associated with.
    /// - Returns: A `SafeDecodingArray` of the specified type.
    /// - Throws: Rethrows any errors encountered during decoding.
    func decodeSafeNullableArray<Element>(
        _ type: Element.Type,
        forKey key: KeyedDecodingContainer<K>.Key
    ) throws -> SafeDecodingArray<Element> where Element: Decodable {
        try decodeIfPresent(SafeDecodingArray<Element>.self, forKey: key) ?? SafeDecodingArray()
    }
}
