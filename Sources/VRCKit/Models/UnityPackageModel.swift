//
//  UnityPackageModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/29.
//

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct UnityPackage: Codable, Sendable, Identifiable, Hashable {
    public let id: String
    public let assetUrl: URL?
    public let assetVersion: Int
    public let createdAt: Date
    public let platform: Platform
    public let unitySortNumber: Int
    public let unityVersion: String

    public enum Platform: String, Codable, Sendable {
        case android, ios, standalonewindows
    }
}
