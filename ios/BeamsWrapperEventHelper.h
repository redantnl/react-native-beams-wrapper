//
//  BeamsWrapperEventHelper.h
//  BeamsWrapper
//
//  Created by RedAnt on 13/01/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface BeamsWrapperEventHelper : RCTEventEmitter

+ (void)emitEventWithName:(NSString *)name andPayload:(NSDictionary *)payload;

@end
