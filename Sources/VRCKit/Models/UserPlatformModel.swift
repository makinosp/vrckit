//
//  UserPlatformModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/02.
//

public enum UserPlatform: String, Codable {
    case android, ios, standalonewindows, web
    case blank = ""
}

extension UserPlatform: Identifiable {
    public var id: String { self.rawValue }
}

extension UserPlatform: CustomStringConvertible {
    public var description: String {
        switch self {
        case .android: "Android"
        case .ios: "iOS"
        case .standalonewindows: "PC"
        case .web: "Web"
        case .blank: ""
        }
    }
}
