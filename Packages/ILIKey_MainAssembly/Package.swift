// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ILIKeyMainAssembly",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ILIKeyMainAssembly",
            targets: ["ILIKeyMainAssembly"]
        ),
        .library(
            name: "IMKCandidatesImpl",
            targets: ["IMKCandidatesImpl"]
        ),
    ],
    dependencies: [
        .package(path: "../vChewing_IMKUtils_ILIKeyImpl"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ILIKeyMainAssembly",
            dependencies: [
                "IOKitCHeaders",
                "IMKCandidatesImpl",
                .product(name: "vChewing_IMKUtils_ILIKeyImpl", package: "vChewing_IMKUtils_ILIKeyImpl"),
            ],
            resources: [
                .process("Resources/Model.xcdatamodeld"),
            ]
        ),
        .target(
            name: "IOKitCHeaders",
            resources: []
        ),
        .target(
            name: "IMKCandidatesImpl",
            resources: []
        ),
        .testTarget(
            name: "ILIKeyMainAssemblyTests",
            dependencies: ["ILIKeyMainAssembly"]
        ),
    ]
)
