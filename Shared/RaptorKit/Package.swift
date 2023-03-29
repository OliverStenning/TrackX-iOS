// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RaptorKit",
    platforms: [.iOS(.v15)],
    products: [.library(name: "RaptorKit", type: .dynamic, targets: ["RaptorKit"])],
    dependencies: [
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", exact: "4.1.1")
    ],
    targets: [
        .target(
            name: "RaptorKit",
            dependencies: [
                .product(name: "SFSafeSymbols", package: "SFSafeSymbols")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "RaptorKitTests",
            dependencies: ["RaptorKit"]
        )
    ]
)
