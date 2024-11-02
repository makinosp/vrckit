//
//  WorldService.swift
//  VRCKit
//
//  Created by kiripoipoi on 2024/09/07.
//

public protocol WorldServiceProtocol: Sendable {
    /// Fetches detailed information about a specific world.
    /// - Parameter worldId: The ID of the world to retrieve.
    /// - Returns: A `World` object containing the details of the specified world.
    /// - Throws: An error if the request fails or decoding is unsuccessful.
    func fetchWorld(worldId: String) async throws -> World

    /// Retrieves the list of favorited worlds.
    /// - Returns: An array of `FavoriteWorld` objects representing the user's favorited worlds.
    /// - Throws: An error if any request fails or decoding is unsuccessful.
    func fetchFavoritedWorlds() async throws -> [FavoriteWorld]

    /// Fetches a paginated list of favorited worlds.
    /// This function retrieves a subset of favorited worlds based on the specified limit and offset.
    /// - Parameters:
    ///   - n: The maximum number of worlds to retrieve in the current request.
    ///   - offset: The offset used to paginate the results.
    /// - Returns: An array of `FavoriteWorld` objects representing a subset of favorited worlds.
    /// - Throws: An error if the request fails or decoding is unsuccessful.
    func fetchFavoritedWorlds(n: Int, offset: Int) async throws -> [FavoriteWorld]
}
