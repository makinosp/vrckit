// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VRCKit",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "VRCKit",
            targets: ["VRCKit"]
        )
    ],
    targets: [
        .target(
            name: "VRCKit",
            path: "Sources"
        ),
        .testTarget(
            name: "VRCKitTests",
            dependencies: ["VRCKit"]
        )
    ]
)
