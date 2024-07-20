//
//  AuthenticationPreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/06.
//

import Foundation

public final class AuthenticationPreviewService: AuthenticationService {
    override public func loginUserInfo() async throws -> UserOrRequires {
        PreviewDataProvider.shared.previewUser
    }

    /// Logout
    override public func logout() async throws {}
}
