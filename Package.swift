// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "swift-key-derivation",
    platforms: [
       .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "KeyDerivation",
            targets: ["KeyDerivation"]),
    ],
    dependencies: [
        .package(name: "CommonCryptoWrapper", url: "https://github.com/arnot-project/swift-commoncrypto", from: "1.0.0"),
        .package(name: "NaCl", url: "https://github.com/arnot-project/swift-nacl", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "KeyDerivation",
            dependencies: ["CommonCryptoWrapper", "NaCl"]),
        .testTarget(
            name: "KeyDerivationTests",
            dependencies: ["KeyDerivation"]),
    ]
)
