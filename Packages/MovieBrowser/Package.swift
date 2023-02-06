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
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.6.0"),
        .package(path: "../TMDBClient"),
        .package(path: "../Utilities"),
        .package(path: "../SharedResources"),
        .package(url: "https://github.com/hmlongco/Resolver.git", from: "1.1.2"),
        .package(url: "https://github.com/kean/Get", from: "1.0.2"),
        .package(url: "https://github.com/WeTransfer/Mocker.git", .upToNextMajor(from: "2.3.0"))
    ],
    targets: [
        .target(
            name: "MovieBrowser",
            dependencies: ["TMDBClient", "Utilities", "Resolver", "Kingfisher", "SharedResources"]),
        .testTarget(
            name: "MovieBrowserTests",
            dependencies: ["MovieBrowser", "TMDBClient", "Get", "Mocker", "Utilities"])
    ]
)
