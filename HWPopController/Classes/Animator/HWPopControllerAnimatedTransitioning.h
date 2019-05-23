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

@property (nonatomic, assign, readonly) HWPopControllerState state;
@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, assign) NSTimeInterval duration;

- (instancetype)initWithState:(HWPopControllerState)state containerView:(UIView *)containerView;

@end

@interface HWPopControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) HWPopControllerState state;
@property (nonatomic, weak, readonly) HWPopController *popController;

- (instancetype)initWithState:(HWPopControllerState)state popController:(HWPopController *)popController NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end





NS_ASSUME_NONNULL_END
