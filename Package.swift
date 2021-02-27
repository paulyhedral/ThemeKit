// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ThemingKit",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v13),
    ],
    products: [
        .library(name: "ThemingKit", type: .dynamic, targets: [ "ThemingKit" ])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", "1.0.0"..<"2.0.0"),
    ],
    targets: [
        .target(name: "ThemingKit", dependencies: [ .product(name: "Logging", package: "swift-log") ]),
        .testTarget(name: "ThemingKitTests", dependencies: [ "ThemingKit" ])
    ]
)
