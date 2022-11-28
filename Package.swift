// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AoC2015",
            targets: ["AoC2015"]),
        .library(
            name: "AoC2020",
            targets: ["AoC2020"]),
        .library(
            name: "AoC2021",
            targets: ["AoC2021"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-collections", .branch("release/1.1")),
        .package(url: "https://github.com/apple/swift-standard-library-preview.git", from: "0.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AdventCore",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "StandardLibraryPreview", package: "swift-standard-library-preview"),
            ]),
        .testTarget(
            name: "AdventCoreTests",
            dependencies: ["AdventCore"]),
        .target(
            name: "AoC2015",
            dependencies: ["AdventCore"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "AoC2015Tests",
            dependencies: ["AoC2015"]),
        .target(
            name: "AoC2020",
            dependencies: ["AdventCore"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "AoC2020Tests",
            dependencies: ["AoC2020"],
            resources: [.process("Resources")]),
        .target(
            name: "AoC2021",
            dependencies: ["AdventCore"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "AoC2021Tests",
            dependencies: ["AoC2021"],
            resources: [.process("Resources")]),
    ]
)
