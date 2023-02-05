// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utilities",
    platforms: [.iOS(.v13), .macCatalyst(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
    products: [
        .library(
            name: "Utilities",
            targets: ["Utilities"])
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Resolver.git", from: "1.1.2"),
        .package(path: "../TMDBClient")
    ],
    targets: [
        .target(
            name: "Utilities",
            dependencies: ["Resolver", "TMDBClient"])
    ]
)
