// swift-tools-version: 6.1
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
        ),
        .executable(
            name: "vrc",
            targets: ["VRCKitCLI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/gohanlon/swift-memberwise-init-macro", from: "0.5.2"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "VRCKit",
            path: "Sources/VRCKit"
        ),
        .executableTarget(
            name: "VRCKitCLI",
            dependencies: [
                "VRCKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/VRCKitCLI"
        ),
        .testTarget(
            name: "VRCKitTests",
            dependencies: ["VRCKit"]
        )
    ]
)

package.targets.forEach { target in
    if target.name == "VRCKit" {
        target.dependencies.append(.product(name: "MemberwiseInit", package: "swift-memberwise-init-macro"))
    }
}
