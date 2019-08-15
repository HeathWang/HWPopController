//
//  HWAnimationConfigListViewController.h
//  HWPopController_Example
//
//  Created by heath wang on 2019/5/23.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HWPopController/HWPop.h>

NS_ASSUME_NONNULL_BEGIN

static inline NSString *stringWithPopType(HWPopType popType) {
    NSArray *array = @[@"None", @"FadeIn", @"GroupIn", @"ShrinkIn", @"SlideInFromTop", @"SlideInFromBottom", @"SlideInFromLeft", @"SlideInFromRight", @"BounceIn", @"BounceInFromTop", @"BounceInFromBottom", @"BounceInFromLeft", @"BounceInFromRight"];
    return array[popType];
}

static inline NSString *stringWithDismissType(HWDismissType dismissType) {
    NSArray *array = @[@"None", @"FadeOut", @"GroupOut", @"ShrinkOut", @"SlideOutFromTop", @"SlideOutFromBottom", @"SlideOutFromLeft", @"SlideOutFromRight", @"BounceOut", @"BounceOutFromTop", @"BounceOutFromBottom", @"BounceOutFromLeft", @"BounceOutFromRight"];
    return array[dismissType];
}

static inline NSString *stringWithPositionType(HWPopPosition position) {
    NSArray *array = @[@"Center", @"Top", @"Bottom"];
    return array[position];
}

@interface HWAnimationConfigListViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
