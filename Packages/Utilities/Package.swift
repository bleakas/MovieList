// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utilities",
    products: [
        .library(
            name: "Utilities",
            targets: ["Utilities"])
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Resolver.git", from: "1.1.2")
    ],
    targets: [
        .target(
            name: "Utilities",
            dependencies: [])
    ]
)
