//
//  NullableArray.swift
//
//
//  Created by makinosp on 2024/07/28.
//

import Foundation

@propertyWrapper
struct NullableArray<T: Decodable>: Decodable {
    var wrappedValue: [T]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.wrappedValue = []
        } else {
            self.wrappedValue = try container.decode([T].self)
        }
    }
}
