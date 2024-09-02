//
//  ImageResolution.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/02.
//

public enum ImageResolution: Int, CustomStringConvertible {
    case x256 = 256
    case x512 = 512
    case x1024 = 1024
    case origin = 0

    public var description: String {
        rawValue.description
    }
}
