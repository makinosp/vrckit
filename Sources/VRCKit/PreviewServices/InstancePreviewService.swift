//
//  InstancePreviewService.swift
//
//
//  Created by makinosp on 2024/07/09.
//

import Foundation

public final class InstancePreviewService: InstanceService {
    override public func fetchInstance(location: String) async throws -> Instance {
        PreviewDataProvider.shared.instances[0]
    }

    override public func fetchInstance(
        worldId: String,
        instanceId: String
    ) async throws -> Instance {
        PreviewDataProvider.shared.instances[0]
    }
}
