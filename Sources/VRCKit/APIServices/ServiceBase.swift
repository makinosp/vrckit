//
//  ServiceBase.swift
//
//
//  Created by makinosp on 2024/07/14.
//

import Foundation

public class APIServiceBase {
    let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }
}
