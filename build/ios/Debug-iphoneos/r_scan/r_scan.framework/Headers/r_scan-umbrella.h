#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FlutterRScanView.h"
#import "RScanCamera.h"
#import "RScanPlugin.h"
#import "RScanResult.h"
#import "RScanView.h"

FOUNDATION_EXPORT double r_scanVersionNumber;
FOUNDATION_EXPORT const unsigned char r_scanVersionString[];

