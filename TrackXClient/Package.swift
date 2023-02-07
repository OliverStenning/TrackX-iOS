// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrackXClient",
    platforms: [.iOS(.v14)],
    products: [.library(name: "TrackXClient", targets: ["TrackXClient"])],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.6.4")
    ],
    targets: [
        .target(
            name: "TrackXClient",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ]
        ),
        .testTarget(
            name: "TrackXClientTests",
            dependencies: ["TrackXClient"]),
    ]
)
