//
//  HWDefaultPopAnimator.m
//  HWPopController
//
//  Created by heath wang on 2019/5/22.
//

#import "HWDefaultPopAnimator.h"
#import "HWPopControllerAnimatedTransitioning.h"

static const CGFloat kDefaultSpringDamping = 0.8;
static const CGFloat kDefaultSpringVelocity = 10.0;

@implementation HWDefaultPopAnimator

- (NSTimeInterval)popControllerAnimationDuration:(HWPopAnimationContext *)context {
    return context.duration ?: 0.2;
}

- (void)popAnimate:(HWPopAnimationContext *)context completion:(void (^)(BOOL finished))completion {
    NSTimeInterval duration = [self popControllerAnimationDuration:context];
    UIView *containerView = context.containerView;
    switch (self.popType) {
        case HWPopTypeFadeIn:{
            containerView.transform = CGAffineTransformIdentity;
            containerView.alpha = 0;
            [UIView animateWithDuration:duration animations:^{
                containerView.alpha = 1;
            } completion:completion];
        }
            break;
        case HWPopTypeGrowIn:{
            containerView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            containerView.alpha = 0;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.transform = CGAffineTransformIdentity;
                containerView.alpha = 1;
            } completion:completion];
        }
            break;
        case HWPopTypeShrinkIn:{
            containerView.alpha = 0;
            containerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.alpha = 1;
                containerView.transform = CGAffineTransformIdentity;
            } completion:completion];
        }
            break;
        case HWPopTypeSlideInFromTop:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            CGRect originFrame = containerView.frame;
            CGRect rect = containerView.frame;
            rect.origin.y = -CGRectGetHeight(originFrame) - 20;
            containerView.frame = rect;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.frame = originFrame;
            } completion:completion];
        }
            break;
        case HWPopTypeSlideInFromBottom:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            CGRect originFrame = containerView.frame;
            CGRect rect = containerView.frame;
            rect.origin.y = containerView.superview.frame.size.height;
            containerView.frame = rect;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.frame = originFrame;
            } completion:completion];
        }
            break;
        case HWPopTypeSlideInFromLeft:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            CGRect originFrame = containerView.frame;
            CGRect rect = containerView.frame;
            rect.origin.x = -CGRectGetWidth(rect);
            containerView.frame = rect;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.frame = originFrame;
            } completion:completion];
        }
            break;
        case HWPopTypeSlideInFromRight:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            CGRect originFrame = containerView.frame;
            CGRect rect = containerView.frame;
            rect.origin.x = CGRectGetWidth(containerView.superview.frame);
            containerView.frame = rect;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.frame = originFrame;
            } completion:completion];
        }
            break;
        case HWPopTypeBounceIn:{
            containerView.transform = CGAffineTransformIdentity;
            containerView.alpha = 0;
            containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                containerView.alpha = 1;
                containerView.transform = CGAffineTransformIdentity;
            } completion:completion];
        }
            break;
        case HWPopTypeBounceInFromTop:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            CGRect originFrame = containerView.frame;
            CGRect rect = containerView.frame;
            rect.origin.y = -CGRectGetHeight(originFrame);
            containerView.frame = rect;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                containerView.frame = originFrame;
            } completion:completion];
        }
            break;
        case HWPopTypeBounceInFromBottom:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            CGRect originFrame = containerView.frame;
            CGRect rect = containerView.frame;
            rect.origin.y = CGRectGetHeight(containerView.superview.frame);
            containerView.frame = rect;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                containerView.frame = originFrame;
            } completion:completion];
        }
            break;
        case HWPopTypeBounceInFromLeft:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            CGRect originFrame = containerView.frame;
            CGRect rect = containerView.frame;
            rect.origin.x = -CGRectGetWidth(rect);
            containerView.frame = rect;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                containerView.frame = originFrame;
            } completion:completion];
        }
            break;
        case HWPopTypeBounceInFromRight:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            CGRect originFrame = containerView.frame;
            CGRect rect = containerView.frame;
            rect.origin.x = CGRectGetWidth(containerView.superview.frame);
            containerView.frame = rect;
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:kDefaultSpringDamping initialSpringVelocity:kDefaultSpringVelocity options:0 animations:^{
                containerView.frame = originFrame;
            } completion:completion];
        }
            break;
        default:{
            containerView.alpha = 1;
            containerView.transform = CGAffineTransformIdentity;
            completion ? completion(YES) : nil;
        }
            break;
    }
}

- (void)dismissAnimate:(HWPopAnimationContext *)context completion:(void (^)(BOOL finished))completion {
    NSTimeInterval duration = [self popControllerAnimationDuration:context];
    NSTimeInterval bounceDuration1 = duration * 1.f / 3.f;
    NSTimeInterval bounceDuration2 = duration * 2.f / 3.f;
    
    UIView *containerView = context.containerView;
    switch (self.dismissType) {
        case HWDismissTypeFadeOut:{
            containerView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:duration animations:^{
                containerView.alpha = 0;
            } completion:completion];
        }
            break;
        case HWDismissTypeGrowOut:{
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                containerView.alpha = 0;
            } completion:completion];
        }
            break;
        case HWDismissTypeShrinkOut:{
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.alpha = 0;
                containerView.transform = CGAffineTransformMakeScale(0.85, 0.85);
            } completion:completion];
        }
            break;
        case HWDismissTypeSlideOutToTop:{
            CGRect rect = containerView.frame;
            rect.origin.y = -CGRectGetHeight(rect);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.frame = rect;
            } completion:completion];
        }
            break;
        case HWDismissTypeSlideOutToBottom:{
            CGRect rect = containerView.frame;
            rect.origin.y = containerView.superview.frame.size.height;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.frame = rect;
            } completion:completion];
        }
            break;
        case HWDismissTypeSlideOutToLeft:{
            CGRect rect = containerView.frame;
            rect.origin.x = -CGRectGetWidth(rect);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.frame = rect;
            } completion:completion];
        }
            break;
        case HWDismissTypeSlideOutToRight:{
            CGRect rect = containerView.frame;
            rect.origin.x = CGRectGetWidth(containerView.superview.frame);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                containerView.frame = rect;
            } completion:completion];
        }
            break;
        case HWDismissTypeBounceOut:{
            [UIView animateWithDuration:bounceDuration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                containerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:bounceDuration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    containerView.alpha = 0;
                    containerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                } completion:completion];
            }];
        }
            break;
        case HWDismissTypeBounceOutToTop:{
            CGRect rect1 = containerView.frame;
            rect1.origin.y += 20;
            CGRect rect2 = containerView.frame;
            rect2.origin.y = -CGRectGetHeight(rect2);
            [UIView animateWithDuration:bounceDuration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                containerView.frame = rect1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:bounceDuration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    containerView.frame = rect2;
                } completion:completion];
            }];
        }
            break;
        case HWDismissTypeBounceOutToBottom:{
            CGRect rect1 = containerView.frame;
            rect1.origin.y -= 20;
            CGRect rect2 = containerView.frame;
            rect2.origin.y = CGRectGetHeight(containerView.superview.frame);
            [UIView animateWithDuration:bounceDuration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                containerView.frame = rect1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:bounceDuration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    containerView.frame = rect2;
                } completion:completion];
            }];
        }
            break;
        case HWDismissTypeBounceOutToLeft:{
            CGRect rect1 = containerView.frame;
            rect1.origin.x += 20;
            CGRect rect2 = containerView.frame;
            rect2.origin.x = -CGRectGetWidth(rect2);
            [UIView animateWithDuration:bounceDuration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                containerView.frame = rect1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:bounceDuration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    containerView.frame = rect2;
                } completion:completion];
            }];
        }
            break;
        case HWDismissTypeBounceOutToRight:{
            CGRect rect1 = containerView.frame;
            rect1.origin.x -= 20;
            CGRect rect2 = containerView.frame;
            rect2.origin.x = CGRectGetWidth(containerView.superview.frame);
            [UIView animateWithDuration:bounceDuration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                containerView.frame = rect1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:bounceDuration2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    containerView.frame = rect2;
                } completion:completion];
            }];
        }
            break;
        default:{
            containerView.alpha = 0;
            containerView.transform = CGAffineTransformIdentity;
            completion ? completion(YES) : nil;
        }
            break;
    }
}

@end
