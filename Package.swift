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
            targets: ["AIHelpSupportSDK", "AIHelpResources"]
        ),
        .library(
            name: "AIHelpSupportSDKCore",
            targets: ["AIHelpSupportSDK"]
        ),
        .library(
            name: "AIHelpResources",
            targets: ["AIHelpResources"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "AIHelpSupportSDK",
            path: "AIHelpSupportSDK.xcframework"
        ),
        .target(
            name: "AIHelpResources",
            dependencies: [],
            path: "Sources/AIHelpResources",
            exclude: [],
            sources: ["AIHelpResources.m"],
            resources: [
                .copy("Resources/Image"),
                .copy("Resources/lan")
            ],
            publicHeadersPath: "include"
        )
    ]
)
