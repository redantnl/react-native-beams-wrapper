# react-native-beams-wrapper

A react native wrapper for Pusher Beams

## Installation

```sh
npm install react-native-beams-wrapper
```

## IOS
Add this to the top of your AppDelegate.m file:

```
@import PushNotifications;
#import <BeamsWrapper.h>
```

Add this in the `didFinishLaunchingWithOptions` function:
```
    [[PushNotifications shared] startWithInstanceId:@"<Your instance id>"]; // Can be found here: https://dash.pusher.com
    [[PushNotifications shared] registerForRemoteNotifications];
```

Add this to the end:
```
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Registered for remote with token: %@", deviceToken);
    [[PushNotifications shared] registerDeviceToken:deviceToken];
    NSError *anyError;
    [[PushNotifications shared] addDeviceInterestWithInterest:@"debug-testing" error:&anyError];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
  [[BeamsWrapper alloc] handleNotification:userInfo];
    NSLog(@"%@", userInfo);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Remote notification support is unavailable due to error: %@", error.localizedDescription);
}
```

## Usage

```js
import BeamsWrapper from "react-native-beams-wrapper";

// ...

const result = await BeamsWrapper.multiply(3, 7);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
