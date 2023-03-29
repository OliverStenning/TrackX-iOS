// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrackXClient",
    platforms: [.iOS(.v15)],
    products: [.library(name: "TrackXClient", type: .dynamic, targets: ["TrackXClient"])],
    dependencies: [],
    targets: [
        .target(
            name: "TrackXClient",
            dependencies: []
        ),
        .testTarget(
            name: "TrackXClientTests",
            dependencies: ["TrackXClient"]
        ),
    ]
)
