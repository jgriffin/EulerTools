// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "EulerTools",
    platforms: [
        .macOS(.v13), .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "EulerTools",
            targets: ["EulerTools"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "EulerTools",
            dependencies: [
                "BigInt",
                .product(name: "Algorithms", package: "swift-algorithms"),
            ],
            resources: [
                .process("WordLists/resources/"),
            ]
        ),
        .testTarget(
            name: "EulerToolsTests",
            dependencies: [
                "EulerTools",
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
    ]
)
