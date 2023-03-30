// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Launch",
    platforms: [.iOS(.v15)],
    products: [.library(name: "Launch", type: .dynamic, targets: ["Launch"])],
    dependencies: [
        .package(path: "../Shared/RaptorKit"),
        .package(path: "../Shared/TrackXClient"),
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", exact: "4.1.1"),
        .package(url: "https://github.com/kean/Nuke.git", exact: "12.1.0")
    ],
    targets: [
        .target(
            name: "Launch",
            dependencies: [
                .product(name: "RaptorKit", package: "RaptorKit"),
                .product(name: "TrackXClient", package: "TrackXClient"),
                .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
                .product(name: "Nuke", package: "Nuke")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "LaunchTests",
            dependencies: ["Launch"]
        )
    ]
)
