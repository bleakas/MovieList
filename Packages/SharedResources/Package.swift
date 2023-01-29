// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedResources",
    platforms: [.iOS(SupportedPlatform.IOSVersion.v16)],
    products: [
        .library(
            name: "SharedResources",
            targets: ["SharedResources"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SharedResources",
            dependencies: []
        )
    ]
)
