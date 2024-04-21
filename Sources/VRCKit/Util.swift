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

    public func decodeResponse<T: Decodable>(
        data: Data,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .formatted(.iso8601Full)
    ) -> Result<T, ErrorResponse> {
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        do {
            let successResponse = try decoder.decode(T.self, from: data)
            return .success(successResponse)
        } catch {
            do {
                let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                return .failure(errorResponse)
            } catch {
                return .failure(ErrorResponse(message: "Failed to decode JSON"))
            }
        }
    }
}
