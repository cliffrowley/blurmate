//
//  BlurMate.m
//  BlurMate
//
//  Created by Cliff Rowley on 15/03/2014.
//  Copyright (c) 2014 Cliff Rowley. All rights reserved.
//

#import "BlurMate.h"

#ifdef DEBUG
#define DebugLog(...) NSLog(__VA_ARGS__)
#else
#define DebugLog(...)
#endif

@implementation BlurMate

- (id)initWithPlugInController:(id <TMPlugInController>)controller {
    NSApp = [NSApplication sharedApplication];

    if ((self = [self init])) {
        DebugLog(@"LOADED BLURMATE!");
        
        if(CGSMainConnectionID == NULL || CGSSetWindowBackgroundBlurRadius == NULL) {
            DebugLog(@"CGSSetWindowBackgroundBlurRadius or CGSMainConnectionID unavailable.");
            DebugLog(@"BlurMate will not work.");
            return self;
        }
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowDidUpdateNotification
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification *note) {
                                                          NSWindow *window = note.object;

                                                          if (!!window) {
                                                              double radius = 20; // the default
                                                              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                              NSNumber *blurRadiusObj = [defaults objectForKey:@"BlurMateRadius"];
                                                              if (!!blurRadiusObj) {
                                                                  radius = [blurRadiusObj doubleValue];
                                                              }
                                                              DebugLog(@"RADIUS: %f", radius);
                                                              [self enableBlurForWindow:window radius:radius];
                                                          }
                                                      }];
    }

    return self;
}

- (void)enableBlurForWindow:(NSWindow *)window radius:(double)radius {
    if(CGSMainConnectionID != NULL && CGSSetWindowBackgroundBlurRadius != NULL) {
        CGSConnectionID con = CGSMainConnectionID();
        if (!con) {
            return;
        }
        CGSSetWindowBackgroundBlurRadius(con, (CGSWindowID)[window windowNumber], (int)radius);
    } else {
        DebugLog(@"Couldn't get blur function");
    }
}

@end
