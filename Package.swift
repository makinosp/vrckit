// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VRCKit",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VRCKit",
            targets: ["VRCKit"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.55.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "VRCKit",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "VRCKitTests",
            dependencies: ["VRCKit"]
        )
    ]
)

package.targets.forEach {
    $0.plugins = [
        .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
    ]
    $0.swiftSettings = [
        .enableUpcomingFeature("ForwardTrailingClosures") // SE-0286
    ]
}
