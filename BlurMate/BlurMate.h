//
//  BlurMate.h
//  BlurMate
//
//  Created by Cliff Rowley on 15/03/2014.
//  Copyright (c) 2014 Cliff Rowley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>
#import "CoreGraphicsServices.h"

@protocol TMPlugInController
- (float)version;
@end

@interface BlurMate : NSObject
- (id)initWithPlugInController:(id <TMPlugInController>)controller;
- (void)enableBlurForWindow:(NSWindow *)window radius:(double)radius;
@end
