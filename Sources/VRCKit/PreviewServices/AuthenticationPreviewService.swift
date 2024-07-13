//
//  AuthenticationPreviewService.swift
//  
//
//  Created by makinosp on 2024/07/06.
//

import Foundation

public class AuthenticationPreviewService: AuthenticationService {
    override public func loginUserInfo() async throws -> UserOrRequires {
        DemoDataProvider.shared.getDemoUesr()
    }

    /// Logout
    override public func logout() async throws {}
}
