/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@import PushNotifications;
#import <BeamsWrapper.h>


#ifdef FB_SONARKIT_ENABLED
#import <FlipperKit/FlipperClient.h>
#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>
static void InitializeFlipper(UIApplication *application) {
  FlipperClient *client = [FlipperClient sharedClient];
  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
  [client addPlugin:[FlipperKitReactPlugin new]];
  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
  [client start];
}
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  #ifdef FB_SONARKIT_ENABLED
    InitializeFlipper(application);
  #endif
<<<<<<< Updated upstream
  
    [[PushNotifications shared] startWithInstanceId:@"4f758dae-7fb9-4314-8341-ff82ccd2b731"]; // Can be found here: https://dash.pusher.com
    [[PushNotifications shared] registerForRemoteNotifications];
=======
  
//  BeamsWrapper * obj = [[BeamsWrapper alloc] init];
//  [obj startInstance:@"test"];

  //[[BeamsWrapper alloc] startInstance:@"4f758dae-7fb9-4314-8341-ff82ccd2b731"];
  
  //NSString *x = @"4f758dae-7fb9-4314-8341-ff82ccd2b731";
  
//  [[PushNotifications shared] startWithInstanceId:@"4f758dae-7fb9-4314-8341-ff82ccd2b731"]; // Can be found here: https://dash.pusher.com
//  [[PushNotifications shared] registerForRemoteNotifications];
//
//  NSError *anyError;
//  [[PushNotifications shared] addDeviceInterestWithInterest:@"debug-test" error:&anyError];
>>>>>>> Stashed changes
  
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"BeamsWrapperExample"
                                            initialProperties:nil];

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//  [[BeamsWrapper shared] registerDeviceToken:deviceToken, "4f758dae-7fb9-4314-8341-ff82ccd2b731"];
<<<<<<< Updated upstream
    NSLog(@"Registered for remote with token: %@", deviceToken);
=======
>>>>>>> Stashed changes
    [[PushNotifications shared] registerDeviceToken:deviceToken];
    NSError *anyError;
    [[PushNotifications shared] addDeviceInterestWithInterest:@"debug-testing" error:&anyError];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
<<<<<<< Updated upstream
  [[BeamsWrapper alloc] handleNotification:userInfo];
=======
  [[BeamsWrapper shared] handleNotification:userInfo, userInfo];
>>>>>>> Stashed changes
//    [[PushNotifications shared] handleNotificationWithUserInfo:userInfo];
    NSLog(@"%@", userInfo);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Remote notification support is unavailable due to error: %@", error.localizedDescription);
}

@end
