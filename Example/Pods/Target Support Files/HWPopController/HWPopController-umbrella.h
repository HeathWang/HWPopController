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

#import "HWDefaultPopAnimator.h"
#import "HWNavAnimatedTransitioning.h"
#import "HWPopControllerAnimatedTransitioning.h"
#import "HWPopControllerAnimationProtocol.h"
#import "NSObject+HWAdd.h"
#import "UIViewController+HWPopController.h"
#import "HWPopController.h"
#import "HWPopNavigationController.h"
#import "HWPop.h"
#import "HWPopTransitioningDelegate.h"

FOUNDATION_EXPORT double HWPopControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char HWPopControllerVersionString[];

