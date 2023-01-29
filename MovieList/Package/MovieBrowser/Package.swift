// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieBrowser",
    platforms: [.iOS(SupportedPlatform.IOSVersion.v16)],
    products: [
        .library(
            name: "MovieBrowser",
            targets: ["MovieBrowser"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MovieBrowser",
            dependencies: [],
            resources: []
        ),
        .testTarget(
            name: "MovieBrowserTests",
            dependencies: ["MovieBrowser"])
    ]
)
