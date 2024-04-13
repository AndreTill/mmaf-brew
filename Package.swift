// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mmaf",
    platforms: [
            .macOS(.v14)
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(name: "mmaf", targets: ["mmaf"]),
    ],
    dependencies: [
        .package(url: "https://github.com/QiuZhiFei/swift-commands.git", branch: "main"),
        .package(url: "https://github.com/vapor/console-kit.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-log.git", branch: "main"),
    
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
                        .process("mirrors_list.plist"),
                        .process("List.txt")
            ]

),
        ]
       )
