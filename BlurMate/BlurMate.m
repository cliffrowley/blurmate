//
//  BlurMate.m
//  BlurMate
//
//  Created by Cliff Rowley on 15/03/2014.
//  Copyright (c) 2014 Cliff Rowley. All rights reserved.
//

#import "BlurMate.h"

@implementation BlurMate

- (id)initWithPlugInController:(id <TMPlugInController>)controller {
    NSApp = [NSApplication sharedApplication];

    if ((self = [self init])) {
        NSLog(@"LOADED BLURMATE!");

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
                                                              NSLog(@"RADIUS: %f", radius);
                                                              [self enableBlurForWindow:window radius:radius];
                                                          }
                                                      }];
    }

    return self;
}

- (void)enableBlurForWindow:(NSWindow *)window radius:(double)radius {
    CGSConnectionID con = CGSMainConnectionID();
    if (!con) {
        return;
    }
    CGSSetWindowBackgroundBlurRadiusFunction* function = GetCGSSetWindowBackgroundBlurRadiusFunction();
    if (function) {
        function(con, (CGSWindowID)[window windowNumber], (int)radius);
    } else {
        NSLog(@"Couldn't get blur function");
    }
}

static void *GetFunctionByName(NSString *library, char *func) {
    CFBundleRef bundle;
    CFURLRef bundleURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef) library, kCFURLPOSIXPathStyle, true);
    CFStringRef functionName = CFStringCreateWithCString(kCFAllocatorDefault, func, kCFStringEncodingASCII);
    bundle = CFBundleCreate(kCFAllocatorDefault, bundleURL);
    void *f = NULL;
    if (bundle) {
        f = CFBundleGetFunctionPointerForName(bundle, functionName);
        CFRelease(bundle);
    }
    CFRelease(functionName);
    CFRelease(bundleURL);
    return f;
}

CGSSetWindowBackgroundBlurRadiusFunction* GetCGSSetWindowBackgroundBlurRadiusFunction(void) {
    static BOOL tried = NO;
    static CGSSetWindowBackgroundBlurRadiusFunction *function = NULL;
    if (!tried) {
        function  = GetFunctionByName(@"/System/Library/Frameworks/ApplicationServices.framework",
                                      "CGSSetWindowBackgroundBlurRadius");
        tried = YES;
    }
    return function;
}

@end
