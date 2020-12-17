#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(BeamsWrapper, NSObject)

RCT_EXTERN_METHOD(multiply:(float)a withB:(float)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(connect:(NSString)userId withToken: (NSString)token withInstanceId: (NSString)instanceId withAuthUrl: (NSString)authUrl)
@end
