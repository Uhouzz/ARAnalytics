#import "UMengAnalyticsProvider.h"
#import "ARAnalyticsProviders.h"
#import "MobClick.h"

@implementation UMengAnalyticsProvider
#ifdef AR_UMENGANALYTICS_EXISTS

- (id) initWithIdentifier:(NSString *)identifier {
    NSAssert([MobClick class], @"MobClick is not included");
    [MobClick startWithAppkey:identifier];

    return [super init];
}

- (void) event:(NSString *)event withProperties:(NSDictionary *)properties {
    [MobClick event:event attributes:properties];
}

- (void) didShowNewPageView:(NSString *)pageTitle {
//	[self event:@"Screen view" withProperties:@{ @"screen": pageTitle }];

    // support Umeng's logPageView logic by set a fixed
//	[MobClick logPageView:pageTitle seconds:0.1];
    [self didShowNewPageView:pageTitle withProperties:nil];
}

- (void) didShowNewPageView:(NSString *)pageTitle withProperties:(NSDictionary *)properties {
    int duration = 0.1;

    if (properties.count && [properties objectForKey:@"length"]) {
        duration = [NSString stringWithFormat:@"%.2f", [properties objectForKey:@"length"]];
    }

    [MobClick logPageView:pageTitle seconds:duration];
}

/// Submit an event with a time interval
- (void) logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval {
    [MobClick event:event durations:(int)([interval doubleValue] * 1000)];
}

/// Submit an event with a time interval and extra properties
/// @warning the properites must not contain the key string `length`.
- (void) logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval properties:(NSDictionary *)properties {
    [MobClick event:event attributes:properties durations:(int)([interval doubleValue] * 1000)];
}

#endif /* ifdef AR_UMENGANALYTICS_EXISTS */
@end
