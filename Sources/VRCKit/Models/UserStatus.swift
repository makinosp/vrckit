//
//  UserStatus.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/20.
//

public enum UserStatus: String, Codable, CaseIterable {
    case joinMe = "join me"
    case active
    case askMe = "ask me"
    case busy
    case offline
}

extension UserStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .joinMe:
            "Join Me"
        case .active:
            "Online"
        case .askMe:
            "Ask Me"
        case .busy:
            "Do Not Disturb"
        case .offline:
            "Offline"
        }
    }
}

extension UserStatus: Identifiable {
    public var id: Int { hashValue }
}
