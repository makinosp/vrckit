//
//  EditableUserModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/24.
//

import Foundation

public struct EditableUserInfo: Codable, Sendable, Hashable {
    public var bio: String
    public var bioLinks: [URL]
    public var status: UserStatus
    public var statusDescription: String
    public var tags: UserTags
}

public extension EditableUserInfo {
    init(detail: any ProfileDetailRepresentable) {
        bio = detail.bio ?? ""
        bioLinks = detail.bioLinks.elements
        status = detail.status
        statusDescription = detail.statusDescription
        tags = detail.tags
    }
}
