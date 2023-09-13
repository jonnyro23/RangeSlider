// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RangeSlider",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "RangeSlider",
            targets: ["RangeSlider"]),
    ],
    dependencies: [
         .package(url: "https://github.com/jonnyro23/Haptics.git", from: "0.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RangeSlider",
            dependencies: ["Haptics"]),
        .testTarget(
            name: "RangeSliderTests",
            dependencies: ["RangeSlider"]),
    ]
)
