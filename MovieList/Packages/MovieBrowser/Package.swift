// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieBrowser",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "MovieBrowser",
            targets: ["MovieBrowser"])
    ],
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "MovieBrowser",
            dependencies: [.product(name: "RswiftLibrary", package: "R.swift")],
                plugins: [.plugin(name: "RswiftGeneratePublicResources", package: "R.swift")]
        ),
        .testTarget(
            name: "MovieBrowserTests",
            dependencies: ["MovieBrowser"])
    ]
)
