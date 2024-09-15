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

public final class CookieManager {
    private var domainURL: String?

    init(domainURL: String) {
        self.domainURL = domainURL
    }

    /// Retrieves the cookies stored for the VRChat API domain.
    /// - Returns: An array of `HTTPCookie` objects.
    public var cookies: [HTTPCookie] {
        guard let domainURL = domainURL,
              let url = URL(string: domainURL),
              let cookies = HTTPCookieStorage.shared.cookies(for: url) else { return [] }
        return cookies
    }

    /// Deletes all cookies stored for the VRChat API domain.
    public func deleteCookies() {
        cookies.forEach { HTTPCookieStorage.shared.deleteCookie($0) }
    }

    var httpField: [String: String] {
        HTTPCookie.requestHeaderFields(with: cookies)
    }
}
