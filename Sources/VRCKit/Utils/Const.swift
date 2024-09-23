//
//  Const.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/06.
//

import Foundation

public enum Const {
    static let homeBaseUrl = "https://vrchat.com/home"
    static let apiBaseUrl = "https://api.vrchat.cloud/api"
    static let apiVersion = 1
    static let assetsUrl = "https://assets.vrchat.com/www/images"
    static let offlineImagePath = "user-location-offline.png"
    static let privateWorldImagePath = "user-location-private-world.png"
    static let locationOnWebImagePath = "user-location-on-web.png"

    public static var offlineImageUrl: URL? {
        URL(string: [Const.assetsUrl, Const.offlineImagePath].joined(separator: "/"))
    }

    public static var privateWorldImageUrl: URL? {
        URL(string: [Const.assetsUrl, Const.privateWorldImagePath].joined(separator: "/"))
    }

    public static var locationOnWebImageUrl: URL? {
        URL(string: [Const.assetsUrl, Const.locationOnWebImagePath].joined(separator: "/"))
    }
}
