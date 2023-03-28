// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utilities",
    platforms: [.iOS(.v15)],
    products: [.library(name: "Utilities", type: .dynamic, targets: ["Utilities"])],
    dependencies: [],
    targets: [
        .target(
            name: "Utilities",
            dependencies: []
        ),
        .testTarget(
            name: "UtilitiesTests",
            dependencies: ["Utilities"]
        )
    ]
)
