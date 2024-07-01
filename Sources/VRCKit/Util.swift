//
//  Util.swift
//  
//
//  Created by makinosp on 2024/03/10.
//

import Foundation

public final class Util {
    public static let shared = Util()
    private var decoder = JSONDecoder()
    private var encoder = JSONEncoder()

    public init() {
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.dateEncodingStrategy = .formatted(.iso8601Full)
    }

    public func urlComponents(_ string: String) throws -> URLComponents {
        guard let urlComponents = URLComponents(string: string) else {
            throw VRCKitError.invalidRequest("Bad URL: \(string)")
        }
        return urlComponents
    }

    public func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            do {
                let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                throw VRCKitError.apiError(errorResponse.error.message)
            } catch let error as DecodingError {
                // for debug
                print(type(of: T.self))
                print(error)
                print(String(decoding: data, as: UTF8.self))
                throw error
            } catch {
                throw error
            }
        }
    }

    public func encode(_ data: Encodable) throws -> Data {
        try encoder.encode(data)
    }
}
