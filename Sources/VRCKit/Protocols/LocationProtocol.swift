//
//  LocationProtocols.swift
//  VRCKit
//
//  Created by makinosp on 2024/06/16.
//

/// Represents a type that has a location string.
public protocol LocationRepresentable {
    var location: String { get }
    var isVisible: Bool { get }
}

public extension LocationRepresentable {
    /// Determines if the location is visible based on predefined criteria.
    var isVisible: Bool {
        !["private", "offline", "traveling"].contains(location)
    }
}
