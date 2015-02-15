//
//  BlurMate.h
//  BlurMate
//
//  Created by Cliff Rowley on 15/03/2014.
//  Copyright (c) 2014 Cliff Rowley. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <ApplicationServices/ApplicationServices.h>

typedef int CGSConnectionID;
typedef int CGSWindowID;

typedef CGError CGSSetWindowBackgroundBlurRadiusFunction(CGSConnectionID cid, CGSWindowID wid, NSUInteger blur);
CGSSetWindowBackgroundBlurRadiusFunction* GetCGSSetWindowBackgroundBlurRadiusFunction(void);

@protocol TMPlugInController
- (float)version;
@end

@interface BlurMate : NSObject
- (id)initWithPlugInController:(id <TMPlugInController>)controller;
- (void)enableBlurForWindow:(NSWindow *)window radius:(double)radius;
@end
