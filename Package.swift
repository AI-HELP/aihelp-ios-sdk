// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AIHelpSupportSDK",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "AIHelpSupportSDK",
            targets: ["AIHelpResources"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "AIHelpSupportSDKBinary",
            path: "AIHelpSupportSDK.xcframework"
        ),
        .target(
            name: "AIHelpResources",
            dependencies: ["AIHelpSupportSDKBinary"],
            path: "Sources/AIHelpResources",
            sources: ["AIHelpResources.m"],
            resources: [
                .copy("Resources/Image"),
                .copy("Resources/lan")
            ],
            publicHeadersPath: "include"
        )
    ]
)
