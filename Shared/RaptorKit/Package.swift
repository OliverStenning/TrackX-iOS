// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RaptorKit",
    platforms: [.iOS(.v15)],
    products: [.library(name: "RaptorKit", type: .dynamic, targets: ["RaptorKit"])],
    dependencies: [],
    targets: [
        .target(
            name: "RaptorKit",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "RaptorKitTests",
            dependencies: ["RaptorKit"]
        )
    ]
)
