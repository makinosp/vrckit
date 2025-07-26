//
//  CookieManager.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/03.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import MemberwiseInit

@MemberwiseInit
public final actor CookieManager {
    @Init(.internal) private var domainURL: String
    @Init(.internal) private let credentialsPath: URL

    init(domainURL: String) {
        self.domainURL = domainURL
        let fileManager = FileManager.default
        let configDir = fileManager.homeDirectoryForCurrentUser
            .appendingPathComponent(".config")
            .appendingPathComponent("vrckit")
        self.credentialsPath = configDir.appendingPathComponent("credentials.json")
        Task { await self.loadCookies() }
    }

    /// Retrieves the cookies stored for the VRChat API domain.
    /// - Returns: An array of `HTTPCookie` objects.
    public var cookies: [HTTPCookie] {
        guard let url = URL(string: domainURL),
              let cookies = HTTPCookieStorage.shared.cookies(for: url) else { return [] }
        return cookies
    }

    /// Deletes all cookies stored for the VRChat API domain.
    public func deleteCookies() {
        cookies.forEach { HTTPCookieStorage.shared.deleteCookie($0) }
        do {
            try FileManager.default.removeItem(at: credentialsPath)
        } catch {
            // Ignore error if file doesn't exist
        }
    }

    public var cookieExists: Bool { !cookies.isEmpty }

    var httpField: [String: String] {
        HTTPCookie.requestHeaderFields(with: cookies)
    }

    func saveCookies() throws {
        let serializableCookies = cookies.map(SerializableCookie.init)
        let data = try JSONEncoder().encode(serializableCookies)
        let directory = credentialsPath.deletingLastPathComponent()
        if !FileManager.default.fileExists(atPath: directory.path) {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        }
        try data.write(to: credentialsPath)
    }

    private func loadCookies() {
        guard FileManager.default.fileExists(atPath: credentialsPath.path) else { return }
        do {
            let data = try Data(contentsOf: credentialsPath)
            let serializableCookies = try JSONDecoder().decode([SerializableCookie].self, from: data)
            serializableCookies.forEach { cookie in
                if let httpCookie = cookie.toHTTPCookie() {
                    HTTPCookieStorage.shared.setCookie(httpCookie)
                }
            }
        } catch {
            // Failed to load or decode cookies, proceed with empty storage.
        }
    }
}
