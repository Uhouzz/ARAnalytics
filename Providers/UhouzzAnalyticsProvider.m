//
//  UhouzzAnalyticsProvider.m
//
//  Created by you on 15/12/18.
//  Copyright © 2015年 you. All rights reserved.
//

#import "UhouzzAnalyticsProvider.h"
#import "ARAnalytics.h"
#import "UhouzzAnalytics.h"

@implementation UhouzzAnalyticsProvider

#ifdef AR_UHOUZZANALYTICS_EXISTS

- (id) initWithIdentifier:(NSString *)identifier {
    NSAssert([UhouzzAnalytics class], @"UhouzzAnalytics is not included");
    [UhouzzAnalytics startWithAppkey:identifier];

    return [super init];
}

- (void) identifyUserWithID:(NSString *)userID andEmailAddress:(NSString *)email {
//    [self identifyUserWithID:userID anonymousID:nil andEmailAddress:email];
    [ARAnalytics addEventSuperProperties:@{ @"user_id": userID, @"email_id": email }];
}

// - (void) identifyUserWithID:(NSString *)userID
//                anonymousID:(NSString *)anonymousID
//            andEmailAddress:(NSString *)email {
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    if (userID && userID.length) {
//        [dict setObject:userID forKey:@"user_id"];
//    }
//
//    if (anonymousID && anonymousID.length) {
//        [dict setObject:anonymousID forKey:@"anonymous_id"];
//    }
//
//    if (email && email.length) {
//        [dict setObject:email forKey:@"email"];
//    }
//
//    [ARAnalytics addEventSuperProperties:dict];
// }

- (void) setUserProperty:(NSString *)property toValue:(NSString *)value {
    NSAssert(property != nil, @"property can not be nil");
    NSAssert(value != nil, @"setUserProperty,value can not be nil");

    [ARAnalytics removeEventSuperProperty:property];
    [ARAnalytics addEventSuperProperties:@{ property:value }];
}

- (void) incrementUserProperty:(NSString *)counterName byInt:(NSNumber *)amount {
    [UhouzzAnalytics incrementUserProperty:counterName byInt:amount];
}

- (void) didShowNewPageView:(NSString *)pageTitle {
    [UhouzzAnalytics logPageView:pageTitle seconds:35];
}

- (void) didShowNewPageView:(NSString *)pageTitle withProperties:(NSDictionary *)properties {
    [UhouzzAnalytics logTimingEvent:pageTitle withInterval:@33 properties:properties];
}

- (void) event:(NSString *)event withProperties:(NSDictionary *)properties {
    [UhouzzAnalytics logEventWithName:event eventData:properties];
}

- (void) logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval {
    [UhouzzAnalytics logTimingEvent:event withInterval:interval];
}

/// Submit an event with a time interval and extra properties
/// @warning the properites must not contain the key string `length`.
- (void) logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval properties:(NSDictionary *)properties {
    [UhouzzAnalytics logTimingEvent:event withInterval:interval properties:properties];
}

/// Monitor Navigation changes as page view
// - (void) monitorNavigationViewController:(UINavigationController *)controller
// {
// }

/// Submit errors
- (void) error:(NSError *)error withMessage:(NSString *)message {
    [UhouzzAnalytics error:error withMessage:message];
}

/// Submit a string to the provider's logging system
- (void) remoteLog:(NSString *)parsedString {
    [UhouzzAnalytics remoteLog:parsedString];
}

/// Submit a string to the local persisted logging system
// - (void) localLog:(NSString *)message
// {
// }

#endif /* ifdef AR_UHOUZZANALYTICS_EXISTS */
@end
