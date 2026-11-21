#import <Foundation/Foundation.h>

NSBundle *AIHelpResourcesBundle(void) __attribute__((used));

static NSBundle *AHBundleNamed(NSBundle *base, NSString *name) {
    if (base == nil) {
        return nil;
    }
    NSString *file = [name stringByAppendingPathExtension:@"bundle"];
    NSURL *url = [base.resourceURL URLByAppendingPathComponent:file];
    NSBundle *bundle = url ? [NSBundle bundleWithURL:url] : nil;
    if (bundle != nil) {
        return bundle;
    }
    url = [base.bundleURL URLByAppendingPathComponent:file];
    return url ? [NSBundle bundleWithURL:url] : nil;
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
