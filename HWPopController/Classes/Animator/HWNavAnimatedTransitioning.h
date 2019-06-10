//
//  HWNavAnimatedTransitioning.h
//  HWPopController
//
//  Created by heath wang on 2019/6/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HWPopController/HWPopController.h>

@class HWNavAnimatedTransitioning;

NS_ASSUME_NONNULL_BEGIN



@interface HWNavAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) HWPopState state;

- (instancetype)initWithState:(HWPopState)state NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
