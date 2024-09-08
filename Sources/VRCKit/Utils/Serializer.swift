//
//  Serializer.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/10.
//

import Foundation

final class Serializer {
    static let shared = Serializer()
    private var decoder = JSONDecoder()
    private var encoder = JSONEncoder()

    /// Initializes the `Util` class, setting up custom encoding and decoding strategies.
    private init() {
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.dateEncodingStrategy = .formatted(.iso8601Full)
    }

    /// Decodes JSON data into a specified `Decodable` type.
    /// - Parameter data: The JSON data to decode.
    /// - Throws: `VRCKitError.apiError` if the decoded data contains an API error.
    /// - Throws: `DecodingError` if the decoding process fails.
    /// - Returns: The decoded object of type `T`.
    func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            do {
                let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                if errorResponse.error.statusCode == 401 {
                    throw VRCKitError.unauthorized
                } else {
                    throw VRCKitError.apiError(errorResponse.error.message)
                }
            } catch _ as DecodingError {
                // for debug
                print(type(of: T.self))
                print(error)
                print(String(decoding: data, as: UTF8.self))
                throw error
            }
        }
    }

    /// Encodes an `Encodable` object into JSON data.
    /// - Parameter data: The object to encode.
    /// - Throws: An error if the encoding process fails.
    /// - Returns: The encoded JSON data.
    func encode(_ data: Encodable) throws -> Data {
        try encoder.encode(data)
    }
}
