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
    }

    public var cookieExists: Bool { !cookies.isEmpty }

    var httpField: [String: String] {
        HTTPCookie.requestHeaderFields(with: cookies)
    }
}
