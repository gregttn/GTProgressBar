// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GTProgressBar",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "GTProgressBar",
            targets: ["GTProgressBar"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GTProgressBar",
            dependencies: [
            ],
            path: "GTProgressBar"
        ),
        .testTarget(
            name: "GTProgressBarTests",
            dependencies: ["GTProgressBar"],
            path: "Tests"
        ),
    ]
)

