# AIHelp iOS SDK

Swift Package Manager distribution for the AIHelp iOS SDK.

## Requirements

- iOS 9.0+
- Xcode 15+

## Installation

In Xcode, choose **File > Add Package Dependencies** and enter:

```
https://github.com/AI-HELP/aihelp-ios-sdk.git
```

Or declare the dependency in `Package.swift`. Release versions are git tags.

```swift
dependencies: [
    .package(url: "https://github.com/AI-HELP/aihelp-ios-sdk.git", from: "6.3.0")
]
```

Add one product to each target:

- App target: `AIHelpSupportSDK`. This links the SDK binary and the resource bundle.
- Unity or an intermediate framework: `AIHelpSupportSDKCore` on the framework target, and `AIHelpResources` on the final App target. The framework runs the SDK code. The App target is what makes Xcode copy `AIHelpSupportSDK_AIHelpResources.bundle` into the `.app`.

Do not add `AIHelpSupportSDK` to both the framework and the App. That links the SDK binary twice.

```swift
.product(name: "AIHelpSupportSDK", package: "AIHelpSupportSDK")
```

This repository contains the SDK package only. The sample project is [sdk-ios-example](https://github.com/AI-HELP/sdk-ios-example).

## Resources

- Documentation: https://docs.aihelp.net/

## License

[Apache-2.0](LICENSE)
