//
//  CoreGraphicsServices.h
//  BlurMate
//
//  Created by Marc-Etienne M.Léveillé on 2015-02-14.
//  Copyright (c) 2015 Cliff Rowley. All rights reserved.
//
//  Private CGS API used by BlurMate
//

#ifndef CoreGraphicsServices_h
#define CoreGraphicsServices_h

typedef NSInteger CGSConnectionID;
typedef NSInteger CGSWindowID;

extern CGSConnectionID CGSMainConnectionID(void) __attribute__((weak_import));

extern CGError CGSSetWindowBackgroundBlurRadius(
                        CGSConnectionID cid, CGSWindowID wid, NSUInteger blur)
                        __attribute__((weak_import));

#endif
