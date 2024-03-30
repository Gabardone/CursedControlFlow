// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CursedControlFlow",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12),
        .macCatalyst(.v13),
        .macOS(.v10_13),
        .tvOS(.v12),
        .visionOS(.v1),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "CursedControlFlow",
            targets: ["CursedControlFlow"]
        )
    ],
    targets: [
        .target(
            name: "CursedControlFlow"
        ),
        .testTarget(
            name: "CursedControlFlowTests",
            dependencies: ["CursedControlFlow"]
        )
    ]
)
