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
            targets: ["AIHelpSupportSDK"]
        ),
        .library(
            name: "AIHelpSupportSDKCore",
            targets: ["AIHelpSupportSDKBinary"]
        ),
        .library(
            name: "AIHelpResources",
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
            path: "Sources/AIHelpResources",
            sources: ["AIHelpResources.m"],
            resources: [
                .copy("Resources/Image"),
                .copy("Resources/lan")
            ],
            publicHeadersPath: "include"
        ),
        .target(
            name: "AIHelpSupportSDK",
            dependencies: [
                "AIHelpSupportSDKBinary",
                "AIHelpResources"
            ],
            path: "Sources/AIHelpSupportSDK",
            sources: ["AIHelpSupportSDKAggregate.m"],
            publicHeadersPath: "include"
        )
    ]
)
