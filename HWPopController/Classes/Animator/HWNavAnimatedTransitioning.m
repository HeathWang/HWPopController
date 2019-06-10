//
//  HWNavAnimatedTransitioning.m
//  HWPopController
//
//  Created by heath wang on 2019/6/10.
//

#import "HWNavAnimatedTransitioning.h"

@implementation HWNavAnimatedTransitioning

- (instancetype)initWithState:(HWPopState)state {
    self = [super init];
    if (self) {
        _state = state;
    }

    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.15;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if (self.state == HWPopStatePop) {
        CGRect f = [transitionContext finalFrameForViewController:toVC];
        toVC.view.frame = f;
        [transitionContext.containerView insertSubview:toVC.view aboveSubview:fromVC.view];
    } else {
        [transitionContext.containerView insertSubview:toVC.view belowSubview:fromVC.view];
    }

    fromVC.view.alpha = 1;
    toVC.view.alpha = 0;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];

        fromVC.view.alpha = 1;
    }];

}

@end
