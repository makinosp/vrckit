//
//  LocationProtocols.swift
//  VRCKit
//
//  Created by makinosp on 2024/06/16.
//

/// Represents a type that has a location string.
public protocol LocationRepresentable: Sendable {
    var location: Location { get }
    var isVisible: Bool { get }
}

public extension LocationRepresentable {
    var isVisible: Bool {
        if case .id = location {
            true
        } else {
            false
        }
    }
}
