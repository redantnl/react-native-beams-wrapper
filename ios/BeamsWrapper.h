#import <React/RCTBridgeModule.h>

@interface BeamsWrapper : NSObject <RCTBridgeModule>

-(void)setDeviceToken:(NSData *)deviceToken;
-(void)handleNotification:(NSDictionary *)userInfo;

@end
