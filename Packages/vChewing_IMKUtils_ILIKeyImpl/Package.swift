// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "vChewing_IMKUtils_ILIKeyImpl",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "vChewing_IMKUtils_ILIKeyImpl",
            targets: ["IMKUtils"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "IMKUtils",
            dependencies: []
        ),
        .testTarget(
            name: "IMKUtilsTests",
            dependencies: ["IMKUtils"]
        ),
    ]
)
