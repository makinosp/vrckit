// swift-tools-version: 6.0
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
    dependencies: [
        .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro", from: "0.5.2")
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

package.targets.forEach { target in
    target.dependencies.append(.product(name: "MemberwiseInit", package: "swift-memberwise-init-macro"))
}
