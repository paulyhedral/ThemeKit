// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "ThemeKit",
    products: [
        .library(name: "ThemeKit", type: .dynamic, targets: [ "ThemeKit" ])
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.6.0")
    ],
    targets: [
        .target(name: "ThemeKit", dependencies: [ "SwiftyBeaver" ]),
        .testTarget(name: "ThemeKitTests", dependencies: [ "ThemeKit" ])
    ]
)
