#import "BeamsWrapper.h"
#import "BeamsWrapperEventHelper.h"
#import "UIKit/UIKit.h"
#import <UIKit/UIKit.h>
#import "RCTLog.h"
@import PushNotifications;

@implementation BeamsWrapper

RCT_EXPORT_MODULE()

// Example method
// See // https://reactnative.dev/docs/native-modules-ios
RCT_REMAP_METHOD(multiply,
                 multiplyWithA:(nonnull NSNumber*)a withB:(nonnull NSNumber*)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
  NSNumber *result = @([a floatValue] * [b floatValue]);

  resolve(result);
}

- (void)handleNotification:(NSDictionary *)userInfo
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;

    NSString *appState = @"active";
    RCTLogInfo(@"handleNotification: %@", userInfo);

    if ( state == UIApplicationStateActive)
    {
        RCTLogInfo(@"1. App is foreground and notification is recieved. Show a alert.");
    }
    else if( state == UIApplicationStateBackground)
    {
        RCTLogInfo(@"2. App is in background and notification is received. You can fetch required data here don't do anything with UI.");
        appState = @"background";
    }
    else if( state == UIApplicationStateInactive)
    {
        RCTLogInfo(@"3. App came in foreground by used clicking on notification. Use userinfo for redirecting to specific view controller.");
        appState = @"inactive";
    }

    if((bool)[userInfo valueForKeyPath:@"aps.data.incrementBadge"]) {
        NSInteger badgeCount = [[UIApplication sharedApplication] applicationIconBadgeNumber];
        [UIApplication sharedApplication].applicationIconBadgeNumber = (badgeCount+1);
        RCTLogInfo(@"increment badge number too: %ld", (long)( badgeCount+1 ));
    }

    [BeamsWrapperEventHelper emitEventWithName:@"notification" andPayload:@{
      @"userInfo":userInfo,
      @"appState":appState
    }];

    [[PushNotifications shared] handleNotificationWithUserInfo:userInfo];
}

- (void)setDeviceToken:(NSData *)deviceToken
{
    RCTLogInfo(@"setDeviceToken: %@", deviceToken);
    [[PushNotifications shared] registerDeviceToken:deviceToken];
    [BeamsWrapperEventHelper emitEventWithName:@"registered" andPayload:@{}];
    RCTLogInfo(@"REGISTERED!");
}

RCT_EXPORT_METHOD(connect:(NSString*)userId:(NSString*)accessToken:(NSString*)instanceId:(NSString*)authUrl)
{
    [[PushNotifications shared] startWithInstanceId:instanceId];
    [[PushNotifications shared] registerForRemoteNotifications];

    BeamsTokenProvider *beamsTokenProvider = [[BeamsTokenProvider alloc] initWithAuthURL:authUrl getAuthData:^AuthData * _Nonnull{
        NSString *sessionToken = accessToken;
        NSDictionary *headers = @{@"Authorization": [NSString stringWithFormat:@"Bearer %@", sessionToken]}; // Headers your auth endpoint needs
        NSDictionary *queryParams = @{}; // URL query params your auth endpoint needs

        return [[AuthData alloc] initWithHeaders:headers queryParams:queryParams];
    }];

    [[PushNotifications shared] setUserId:userId tokenProvider:beamsTokenProvider completion:^(NSError * _Nullable anyError) {
        if (anyError) {
            NSLog(@"Error: %@", anyError);
        }
        else {
            NSLog(@"Successfully authenticated with Pusher Beams");
        }
    }];
}

RCT_EXPORT_METHOD(disconnect)
{
  [[PushNotifications shared] clearAllStateWithCompletion:^() {
    RCTLogInfo(@"Finished clearing the SDK state");
  }];
}

@end
