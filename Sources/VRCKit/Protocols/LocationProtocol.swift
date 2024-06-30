//
//  LocationProtocols.swift
//
//
//  Created by makinosp on 2024/06/16.
//

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public protocol LocationRepresentable {
    var location: String { get }
}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public extension LocationRepresentable {
    var isVisible: Bool {
        !["private", "offline", "traveling"].contains(location)
    }
}
