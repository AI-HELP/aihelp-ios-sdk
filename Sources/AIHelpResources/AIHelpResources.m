#import <Foundation/Foundation.h>

NSBundle *AIHelpResourcesBundle(void) __attribute__((used));

static NSBundle *AHBundleIfPresent(NSURL *url) {
    if (url == nil || url.fileURL == NO) {
        return nil;
    }
    BOOL isDirectory = NO;
    if (![NSFileManager.defaultManager fileExistsAtPath:url.path isDirectory:&isDirectory] || !isDirectory) {
        return nil;
    }
    return [NSBundle bundleWithURL:url];
}

static NSBundle *AHBundleNamed(NSBundle *base, NSString *name) {
    if (base == nil) {
        return nil;
    }
    NSString *file = [name stringByAppendingPathExtension:@"bundle"];
    NSBundle *bundle = AHBundleIfPresent([base.resourceURL URLByAppendingPathComponent:file]);
    if (bundle != nil) {
        return bundle;
    }
    return AHBundleIfPresent([base.bundleURL URLByAppendingPathComponent:file]);
}

NSBundle *AIHelpResourcesBundle(void) {
    NSString *name = @"AIHelpSupportSDK_AIHelpResources";
    NSMutableArray<NSBundle *> *bases = [NSMutableArray arrayWithObject:NSBundle.mainBundle];
    [bases addObjectsFromArray:NSBundle.allFrameworks];
    [bases addObjectsFromArray:NSBundle.allBundles];
    for (NSBundle *base in bases) {
        NSBundle *found = AHBundleNamed(base, name);
        if (found != nil) {
            return found;
        }
    }
    return nil;
}
