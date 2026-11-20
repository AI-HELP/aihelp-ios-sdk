#import <Foundation/Foundation.h>
#import "resource_bundle_accessor.h"

NSBundle *AIHelpResourcesBundle(void) __attribute__((used));
NSBundle *AIHelpResourcesBundle(void) {
    return SWIFTPM_MODULE_BUNDLE;
}
