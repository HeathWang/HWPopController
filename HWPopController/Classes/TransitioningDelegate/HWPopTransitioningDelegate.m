//
//  HWPopTransitioningDelegate.m
//  HWPopController
//
//  Created by heath wang on 2019/5/21.
//

#import "HWPopTransitioningDelegate.h"
#import "HWPopControllerAnimatedTransitioning.h"

@implementation HWPopTransitioningDelegate

- (instancetype)initWithPopController:(HWPopController *)popController {
	self = [super init];
	if (self) {
		_popController = popController;
	}

	return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
	return [[HWPopControllerAnimatedTransitioning alloc] initWithState:HWPopStatePop popController:self.popController];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
	return [[HWPopControllerAnimatedTransitioning alloc] initWithState:HWPopStateDismiss popController:self.popController];
}

@end
