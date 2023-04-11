// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mmaf",
    platforms: [
            .macOS(.v13)
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(name: "mmaf", targets: ["mmaf"]),
    ],
    dependencies: [
        .package(url: "https://github.com/QiuZhiFei/swift-commands.git", .upToNextMajor(from: "0.6.0")),
        .package(url: "https://github.com/vapor/console-kit.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.0.0")),
    
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "mmaf",
            dependencies: [
                .product(name: "Commands", package: "swift-commands"),
                .product(name: "ConsoleKit", package: "console-kit"),
                .product(name: "Logging", package: "swift-log"),
            ],
            resources: [
                        .process("mirrors_list.plist")
            ]
),

    ]
)
