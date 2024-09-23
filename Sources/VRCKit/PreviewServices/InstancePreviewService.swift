//
//  InstancePreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/09.
//

public final actor InstancePreviewService: APIService, InstanceServiceProtocol {
    let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    public func fetchInstance(location: String) async throws -> Instance {
        PreviewDataProvider.shared.instances[0]
    }

    public func fetchInstance(
        worldId: String,
        instanceId: String
    ) async throws -> Instance {
        PreviewDataProvider.shared.instances[0]
    }
}
