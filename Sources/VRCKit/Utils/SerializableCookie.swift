import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import MemberwiseInit

@MemberwiseInit(.public)
public struct SerializableCookie: Codable {
    public let name: String
    public let value: String
    public let domain: String
    public let path: String
    public let expiresDate: Date?
    public let isSecure: Bool
    public let isHTTPOnly: Bool

    func toHTTPCookie() -> HTTPCookie? {
        var properties: [HTTPCookiePropertyKey: Any] = [
            .name: name,
            .value: value,
            .domain: domain,
            .path: path
        ]
        if let expiresDate = expiresDate {
            properties[.expires] = expiresDate
        }
        properties[.secure] = isSecure
        properties[.init("HttpOnly")] = isHTTPOnly
        return HTTPCookie(properties: properties)
    }
}

public extension SerializableCookie {
    init(httpCookie: HTTPCookie) {
        name = httpCookie.name
        value = httpCookie.value
        domain = httpCookie.domain
        path = httpCookie.path
        expiresDate = httpCookie.expiresDate
        isSecure = httpCookie.isSecure
        isHTTPOnly = httpCookie.isHTTPOnly
    }
}
