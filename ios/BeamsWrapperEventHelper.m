<<<<<<< Updated upstream
//
//  BeamsWrapperEventHelper.m
//  BeamsWrapper
//
//  Created by RedAnt on 13/01/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

=======
>>>>>>> Stashed changes
#import "BeamsWrapperEventHelper.h"

@implementation BeamsWrapperEventHelper

RCT_EXPORT_MODULE();

// The list of available events
- (NSArray<NSString *> *)supportedEvents {
    return @[@"registered", @"notification"];
}

// This function listens for the events we want to send out and will then pass the
// payload over to the emitEventInternal function for sending to Javascript
- (void)startObserving
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emitEventInternal:)
                                                 name:@"event-emitted"
                                               object:nil];
}

// This will stop listening if we require it
- (void)stopObserving
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// This will actually throw the event out to our Javascript
- (void)emitEventInternal:(NSNotification *)notification
{
    // We will receive the dictionary here - we now need to extract the name
    // and payload and throw the event
    NSArray *eventDetails = [notification.userInfo valueForKey:@"detail"];
    NSString *eventName = [eventDetails objectAtIndex:0];
    NSDictionary *eventData = [eventDetails objectAtIndex:1];
    
    [self sendEventWithName:eventName
                       body:eventData];
}

// This is our static function that we call from our code
+ (void)emitEventWithName:(NSString *)name andPayload:(NSDictionary *)payload
{
    // userInfo requires a dictionary so we wrap out name and payload into an array and stick
    // that into the dictionary with a key of 'detail'
    NSDictionary *eventDetail = @{@"detail":@[name,payload]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"event-emitted"
                                                        object:self
                                                      userInfo:eventDetail];
}

<<<<<<< Updated upstream
@end
=======
@end
>>>>>>> Stashed changes
