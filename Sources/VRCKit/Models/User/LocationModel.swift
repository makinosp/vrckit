//
//  LocationModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/08.
//

public enum Location: Sendable, Hashable {
    case id(String), `private`, offline, traveling
}

extension Location: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case "private":
            self = .private
        case "offline":
            self = .offline
        case "traveling":
            self = .traveling
        default:
            self = .id(value)
        }
    }
}
