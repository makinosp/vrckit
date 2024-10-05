//
//  UserTagModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

import MemberwiseInit

@MemberwiseInit(.public)
public struct UserTags: Hashable, Sendable {
    @Init(default: [])
    public var systemTags: [SystemTag]
    @Init(default: [])
    public var languageTags: [LanguageTag]
    @Init(default: [])
    public var unknownTags: [String]
}

extension UserTags: Decodable {
    public init(from decoder: Decoder) throws {
        var decoded = UserTags()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let systemTag = try? container.decode(SystemTag.self)
            let languageTag = try? container.decode(LanguageTag.self)
            if systemTag == nil, languageTag == nil {
                decoded.unknownTags.append(try container.decode(String.self))
                continue
            }
            if let systemTag = systemTag {
                decoded.systemTags.append(systemTag)
            }
            if let languageTag = languageTag {
                decoded.languageTags.append(languageTag)
            }
        }
        self = decoded
    }
}

extension UserTags: Encodable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        let tags = languageTags.map(\.rawValue)
        for tag in tags {
            try container.encode(tag)
        }
    }
}
