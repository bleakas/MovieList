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
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "2.0.0"),
        .package(path: "../TMDBClient"),
        .package(url: "https://github.com/hmlongco/Resolver.git", from: "1.1.2")
    ],
    targets: [
        .target(
            name: "MovieBrowser",
            dependencies: ["TMDBClient"]),
        .testTarget(
            name: "MovieBrowserTests",
            dependencies: ["MovieBrowser", "TMDBClient"])
    ]
)
