#import <Foundation/Foundation.h>

NSBundle *AIHelpResourcesBundle(void) __attribute__((used));

static BOOL AHIsValidResourceBundleAtURL(NSURL *bundleURL) {
    if (bundleURL == nil || bundleURL.fileURL == NO) {
        return NO;
    }
    NSString *bundlePath = bundleURL.path;
    if (bundlePath.length == 0) {
        return NO;
    }
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:@"Image/ai_home.png"];
    NSString *localizationPath = [bundlePath stringByAppendingPathComponent:@"lan/en.lproj/Localizable.strings"];
    NSFileManager *fileManager = NSFileManager.defaultManager;
    return [fileManager fileExistsAtPath:imagePath] &&
           [fileManager fileExistsAtPath:localizationPath];
}

static NSBundle *AHBundleNamed(NSBundle *base, NSString *name) {
    if (base == nil) {
        return nil;
    }
    NSString *file = [name stringByAppendingPathExtension:@"bundle"];
    NSURL *url = [base.resourceURL URLByAppendingPathComponent:file];
    if (AHIsValidResourceBundleAtURL(url)) {
        return [NSBundle bundleWithURL:url];
    }
    url = [base.bundleURL URLByAppendingPathComponent:file];
    if (AHIsValidResourceBundleAtURL(url)) {
        return [NSBundle bundleWithURL:url];
    }
    return nil;
}

static NSBundle *AHBundleAtURLIfValid(NSURL *bundleURL) {
    if (!AHIsValidResourceBundleAtURL(bundleURL)) {
        return nil;
    }
    return [NSBundle bundleWithURL:bundleURL];
}

NSBundle *AIHelpResourcesBundle(void) {
    NSString *resourceBundleName = @"AIHelpSupportSDK_AIHelpResources";
    NSBundle *mainBundle = NSBundle.mainBundle;

    NSArray<NSURL *> *explicitURLs = @[
        [mainBundle.bundleURL URLByAppendingPathComponent:
         [resourceBundleName stringByAppendingPathExtension:@"bundle"]],
        [[mainBundle.bundleURL URLByAppendingPathComponent:@"Frameworks/UnityFramework.framework"]
            URLByAppendingPathComponent:[resourceBundleName stringByAppendingPathExtension:@"bundle"]]
    ];
    for (NSURL *bundleURL in explicitURLs) {
        NSBundle *bundle = AHBundleAtURLIfValid(bundleURL);
        if (bundle != nil) {
            return bundle;
        }
    }

    NSMutableArray<NSBundle *> *bases = [NSMutableArray arrayWithObject:mainBundle];
    [bases addObjectsFromArray:NSBundle.allFrameworks];
    [bases addObjectsFromArray:NSBundle.allBundles];
    for (NSBundle *base in bases) {
        NSBundle *found = AHBundleNamed(base, resourceBundleName);
        if (found != nil) {
            return found;
        }
        for (NSURL *bundleURL in [base URLsForResourcesWithExtension:@"bundle" subdirectory:nil]) {
            NSString *fileName = bundleURL.lastPathComponent.stringByDeletingPathExtension;
            if (![fileName isEqualToString:resourceBundleName] &&
                [fileName hasSuffix:@"_AIHelpResources"] == NO) {
                continue;
            }
            NSBundle *bundle = AHBundleAtURLIfValid(bundleURL);
            if (bundle != nil) {
                return bundle;
            }
        }
    }
    return nil;
}
