//
//  AuthenticationPreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/06.
//

public final actor AuthenticationPreviewService: APIService, AuthenticationServiceProtocol {
    let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    public func isExists(userId: String) async throws -> Bool { true }

    public func loginUserInfo() async throws -> UserOrRequires {
        await PreviewDataProvider.shared.previewUser
    }

    public func verify2FA(verifyType: VerifyType, code: String) async throws -> Bool { true }

    public func verifyAuthToken() async throws -> Bool { true }

    public func logout() async throws {}
}
