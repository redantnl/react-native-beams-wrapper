#import <React/RCTBridgeModule.h>

@interface BeamsWrapper : NSObject <RCTBridgeModule>

- (void)start:(NSString *)instanceId;

@end
