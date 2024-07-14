//
//  UserPreviewService.swift
//  
//
//  Created by makinosp on 2024/07/14.
//

import Foundation

public final class UserPreviewService: UserService {
    override public func fetchUser(userId: String) async throws -> UserDetail {
        PreviewDataProvider.shared.userDetails.first { $0.id == userId }!
    }
}
