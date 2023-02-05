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
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "SharedResources",
            dependencies: [.product(name: "RswiftLibrary", package: "R.swift")],
            resources: [.copy("SharedResourcesResources")],
            plugins: [.plugin(name: "RswiftGeneratePublicResources", package: "R.swift")]
        )
    ]
)
