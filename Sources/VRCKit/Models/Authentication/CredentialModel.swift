//
//  CredentialModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/10/19.
//

import MemberwiseInit

@MemberwiseInit(.public)
public struct Credential: Sendable {
    public let username: String
    public let password: String
}

extension Credential {
    var authString: String {
        "\(username):\(password)"
    }
}
