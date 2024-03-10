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

    private init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
    }
}
