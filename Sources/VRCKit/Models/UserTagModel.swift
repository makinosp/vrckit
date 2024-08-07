//
//  UserTagModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/04.
//

public struct UserTags: Codable, Hashable {
    let systemTags: [SystemTag]
    var languageTags: [LanguageTag]
    let unknownTags: [String]
}

public extension UserTags {
    init() {
        systemTags = []
        languageTags = []
        unknownTags = []
    }
}

public extension UserTags {
    init(from decoder: Decoder) throws {
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
