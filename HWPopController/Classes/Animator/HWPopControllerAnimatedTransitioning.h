//
//  HWPopControllerAnimationContext.h
//  HWPopController
//
//  Created by heath wang on 2019/5/21.
//

#import <Foundation/Foundation.h>
#import <HWPopController/HWPopController.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWPopAnimationContext : NSObject

@property (nonatomic, assign, readonly) HWPopState state;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign) NSTimeInterval duration;

- (instancetype)initWithState:(HWPopState)state containerView:(UIView *)containerView;

@end

@interface HWPopControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) HWPopState state;
@property (nonatomic, weak, readonly) HWPopController *popController;

- (instancetype)initWithState:(HWPopState)state popController:(HWPopController *)popController NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
