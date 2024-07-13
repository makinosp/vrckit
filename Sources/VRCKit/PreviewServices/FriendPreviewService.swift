//
//  FriendPreviewService.swift
//
//
//  Created by makinosp on 2024/07/07.
//

import Foundation

public class FriendPreviewService: FriendService {
    override public func fetchFriends(offset: Int, n: Int, offline: Bool) async throws -> [Friend] {
        var friends: [Friend] = []
        if !offline {
            friends = DemoDataProvider.shared.onlineFriends
        }
        return friends
    }
}
