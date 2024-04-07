//
//  Util.swift
//  
//
//  Created by makinosp on 2024/03/10.
//

import Foundation

final public class Util {
    public static let shared = Util()
    public let decoder: JSONDecoder
    public let encoder: JSONEncoder

    private init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(.iso8601Full)
    }
}
