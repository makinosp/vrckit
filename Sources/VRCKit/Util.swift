//
//  Util.swift
//  
//
//  Created by makinosp on 2024/03/10.
//

import Foundation

final public class Util {
    public static let shared = Util()
    private var decoder = JSONDecoder()
    private var encoder = JSONEncoder()

    public func urlComponents(_ string: String) throws -> URLComponents {
        guard let urlComponents = URLComponents(string: string) else {
            throw VRCKitError.invalidRequest("Bad URL: \(string)")
        }
        return urlComponents
    }

    public func decodeResponse<T: Decodable>(
        _ data: Data,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .formatted(.iso8601Full)
    ) -> Result<T, ErrorResponse> {
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        do {
            let successResponse = try decoder.decode(T.self, from: data)
            return .success(successResponse)
        } catch {
            print("Failed to decode \(String(describing: T.self)):", error)
            do {
                let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                return .failure(errorResponse)
            } catch {
                print("Failed to decode error response:", error)
                return .failure(ErrorResponse(message: "Failed to decode JSON"))
            }
        }
    }

    public func decode<T: Decodable>(_ data: Data) throws -> T {
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to decode \(String(describing: T.self)):", error)
            let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
            throw VRCKitError.apiError(errorResponse.error.message)
        }
    }

    public func encodeRequest(
        _ data: Encodable,
        keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase,
        dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .formatted(.iso8601Full)
    ) -> Result<Data, Error> {
        encoder.keyEncodingStrategy = keyEncodingStrategy
        encoder.dateEncodingStrategy = dateEncodingStrategy
        do {
            return .success(try encoder.encode(data))
        } catch {
            return .failure(VRCKitError.encodingError)
        }
    }

    public func encode(_ data: Encodable) throws -> Data {
        encoder.dateEncodingStrategy = .formatted(.iso8601Full)
        return try encoder.encode(data)
    }
}
