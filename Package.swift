// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "ThemingKit",
    products: [
        .library(name: "ThemingKit", type: .dynamic, targets: [ "ThemingKit" ])
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.6.0")
    ],
    targets: [
        .target(name: "ThemingKit", dependencies: [ "SwiftyBeaver" ]),
        .testTarget(name: "ThemingKitTests", dependencies: [ "ThemingKit" ])
    ]
)
