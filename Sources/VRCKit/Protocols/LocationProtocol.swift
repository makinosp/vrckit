//
//  LocationProtocols.swift
//  VRCKit
//
//  Created by makinosp on 2024/06/16.
//

/// Represents a type that has a location string.
public protocol LocationRepresentable: Sendable {
    var location: Location { get }
}
