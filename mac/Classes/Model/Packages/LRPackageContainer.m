
#import "LRPackageContainer.h"


@interface LRPackageContainer ()

@end


@implementation LRPackageContainer

- (instancetype)initWithPackageType:(LRPackageType *)packageType {
    self = [super init];
    if (self) {
        _packageType = packageType;
    }
    return self;
}

- (NSArray *)packagesMatchingReference:(LRPackageReference *)reference {
    abort();
}

- (LRPackage *)bestPackageMatchingReference:(LRPackageReference *)reference {
    NSArray *choices = [self packagesMatchingReference:reference];
    if (choices.count == 0)
        return nil;
    else
        return [choices firstObject];  // TODO return the best object
}

- (void)startTrackingPackages {
    [self _updatePackages];
}

- (void)endTrackingPackages {

}

- (void)_updatePackages {
    if (_updateInProgress)
        return;

    _updateInProgress = YES;
    NSLog(@"%@: updating", self);
    [self doUpdate];
}

- (void)doUpdate {
    [self updateSucceededWithPackages:@[]];
}

- (void)updateSucceededWithPackages:(NSArray *)packages {
    NSLog(@"%@: update succeeded, found %d packages: %@", self, (int)packages.count, [packages componentsJoinedByString:@", "]);
    _packages = packages;
    _updateInProgress = NO;
}

- (void)updateFailedWithError:(NSError *)error {
    NSLog(@"%@: update failed: %@ - %ld - %@", self, error.domain, (long)error.code, error.localizedDescription);
    _updateInProgress = NO;
}

@end
