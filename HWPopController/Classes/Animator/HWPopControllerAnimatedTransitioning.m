//
//  HWPopControllerAnimationContext.m
//  HWPopController
//
//  Created by heath wang on 2019/5/21.
//

#import "HWPopControllerAnimatedTransitioning.h"
#import "HWDefaultPopAnimator.h"

@implementation HWPopAnimationContext

- (instancetype)initWithState:(HWPopState)state containerView:(UIView *)containerView {
	self = [super init];
	if (self) {
		_state = state;
		_containerView = containerView;
	}

	return self;
}


@end

@interface HWPopControllerAnimatedTransitioning ()

@property (nonatomic, strong) id<HWPopControllerAnimationProtocol> animator;

@end

@interface HWPopControllerAnimatedTransitioning ()

@property (nonatomic, strong, readonly) UIView *containerView;
@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, strong) HWPopAnimationContext *animationContext;

@end

@implementation HWPopControllerAnimatedTransitioning

- (instancetype)initWithState:(HWPopState)state popController:(HWPopController *)popController {
	self = [super init];
	if (self) {
		_state = state;
		_popController = popController;
		_containerView = _popController.containerView;
		_backgroundView = _popController.backgroundView;
		_animationContext = [[HWPopAnimationContext alloc] initWithState:state containerView:_containerView];
		_animationContext.duration = _popController.animationDuration;

		[self getAnimator];
	}

	return self;
}

- (void)getAnimator {
	if (self.popController.animationProtocol) {
		self.animator = self.popController.animationProtocol;
	} else {
		HWDefaultPopAnimator *defaultPopAnimator = [HWDefaultPopAnimator new];
		defaultPopAnimator.popType = self.popController.popType;
		defaultPopAnimator.dismissType = self.popController.dismissType;
		self.animator = defaultPopAnimator;
	}
}

#pragma mark - Animation

- (void)popAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	toViewController.view.frame = fromViewController.view.frame;

	UIViewController *topViewController = self.popController.topViewController;
	[fromViewController beginAppearanceTransition:NO animated:YES];

	[[transitionContext containerView] addSubview:toViewController.view];

	[topViewController beginAppearanceTransition:YES animated:YES];
	[toViewController addChildViewController:topViewController];
	[self.popController.contentView addSubview:topViewController.view];

	[self.popController layoutContainerView];

	CGFloat lastBackgroundViewAlpha = self.backgroundView.alpha;
	self.backgroundView.alpha = 0;
	[self setContainerUserInteractionEnabled:NO];
	self.containerView.transform = CGAffineTransformIdentity;

	[UIView animateWithDuration:[self.animator popControllerAnimationDuration:self.animationContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundView.alpha = lastBackgroundViewAlpha;
	} completion:nil];

	[self.animator popAnimate:self.animationContext completion:^(BOOL finished){
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
		[self setContainerUserInteractionEnabled:YES];
		
		[topViewController endAppearanceTransition];
		[topViewController didMoveToParentViewController:toViewController];
		[fromViewController endAppearanceTransition];
        [toViewController setNeedsStatusBarAppearanceUpdate];
	}];
}

- (void)dismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	toViewController.view.frame = fromViewController.view.frame;

	UIViewController *topViewController = self.popController.topViewController;

	[toViewController beginAppearanceTransition:YES animated:YES];

	[topViewController beginAppearanceTransition:NO animated:YES];
	[topViewController willMoveToParentViewController:nil];

	CGFloat lastBackgroundViewAlpha = self.backgroundView.alpha;
	[self setContainerUserInteractionEnabled:NO];

	[UIView animateWithDuration:[self.animator popControllerAnimationDuration:self.animationContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundView.alpha = 0;
	} completion:nil];

	[self.animator dismissAnimate:self.animationContext completion:^(BOOL finished){
		[self setContainerUserInteractionEnabled:YES];
        self.backgroundView.alpha = lastBackgroundViewAlpha;

		[fromViewController.view removeFromSuperview];
		[topViewController.view removeFromSuperview];
		[topViewController removeFromParentViewController];
		[toViewController endAppearanceTransition];

		[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
	}];

}

- (void)setContainerUserInteractionEnabled:(BOOL)enabled {
	self.containerView.userInteractionEnabled = enabled;
	self.backgroundView.userInteractionEnabled = enabled;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {

    return [self.animator popControllerAnimationDuration:self.animationContext];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	switch (self.state) {
		case HWPopStatePop: {
			[self popAnimateTransition:transitionContext];
		}
			break;
		case HWPopStateDismiss:{
			[self dismissTransition:transitionContext];
		}
			break;
	}
}

@end
