//
//  UserTagModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

public struct UserTags: Hashable {
    public var systemTags: [SystemTag]
    public var languageTags: [LanguageTag]
    public var unknownTags: [String]
}

public extension UserTags {
    init() {
        systemTags = []
        languageTags = []
        unknownTags = []
    }
}

extension UserTags: Decodable {
    public init(from decoder: Decoder) throws {
        var systemTags: [SystemTag] = []
        var languageTags: [LanguageTag] = []
        var unknownTags: [String] = []
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let systemTag = try? container.decode(SystemTag.self)
            let languageTag = try? container.decode(LanguageTag.self)
            if systemTag == nil, languageTag == nil {
                unknownTags.append(try container.decode(String.self))
                continue
            }
            if let systemTag = systemTag {
                systemTags.append(systemTag)
            }
            if let languageTag = languageTag {
                languageTags.append(languageTag)
            }
        }
        self.systemTags = systemTags
        self.languageTags = languageTags
        self.unknownTags = unknownTags
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
