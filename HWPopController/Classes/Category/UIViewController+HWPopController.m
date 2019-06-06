//
//  UIViewController+HWPopController.m
//  HWPopController
//
//  Created by heath wang on 2019/5/21.
//

#import "UIViewController+HWPopController.h"
#import <objc/runtime.h>
#import "NSObject+HWAdd.h"

@implementation UIViewController (HWPopController)

@dynamic contentSizeInPop;
@dynamic contentSizeInPopWhenLandscape;
@dynamic popController;

static inline BOOL HW_FLOAT_VALUE_IS_ZERO(CGFloat value) {
    return (value > -FLT_EPSILON) && (value < FLT_EPSILON);
}

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
        [self hw_swizzleInstanceMethod:@selector(viewDidLoad) with:@selector(hw_viewDidLoad)];
        [self hw_swizzleInstanceMethod:@selector(presentViewController:animated:completion:) with:@selector(hw_presentViewController:animated:completion:)];
        [self hw_swizzleInstanceMethod:@selector(dismissViewControllerAnimated:completion:) with:@selector(hw_dismissViewControllerAnimated:completion:)];
	});
}

- (void)hw_viewDidLoad {

	[self hw_viewDidLoad];

    CGSize contentSize;
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:{
            contentSize = self.contentSizeInPopWhenLandscape;
            if (CGSizeEqualToSize(contentSize, CGSizeZero)) {
                contentSize = self.contentSizeInPop;
            }
        }
            break;
        default:{
            contentSize = self.contentSizeInPop;
        }
            break;
    }

    if (!CGSizeEqualToSize(contentSize, CGSizeZero)) {
    	self.view.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    }

}

- (void)hw_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (!self.popController) {
        [self hw_presentViewController:viewControllerToPresent animated:flag completion:completion];
        return;
    }
    
    [[self.popController valueForKey:@"containerViewController"] hw_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)hw_dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    if (!self.popController) {
        [self hw_dismissViewControllerAnimated:flag completion:completion];
        return;
    }
    
    [self.popController dismissWithCompletion:completion];
}

#pragma mark - props

- (CGSize)contentSizeInPop {
	NSValue *value = objc_getAssociatedObject(self, _cmd);
	return [value CGSizeValue];
}

- (void)setContentSizeInPop:(CGSize)contentSizeInPop {
	if (!CGSizeEqualToSize(contentSizeInPop, CGSizeZero) && HW_FLOAT_VALUE_IS_ZERO(contentSizeInPop.width)) {
		switch ([UIApplication sharedApplication].statusBarOrientation) {
			case UIInterfaceOrientationLandscapeLeft:
			case UIInterfaceOrientationLandscapeRight:{
				contentSizeInPop.width = [UIScreen mainScreen].bounds.size.height;
			}
				break;
			default: {
				contentSizeInPop.width = [UIScreen mainScreen].bounds.size.width;
			}
				break;

		}
	}

	objc_setAssociatedObject(self, @selector(contentSizeInPop), [NSValue valueWithCGSize:contentSizeInPop], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)contentSizeInPopWhenLandscape {
	NSValue *value = objc_getAssociatedObject(self, _cmd);
	return [value CGSizeValue];
}

- (void)setContentSizeInPopWhenLandscape:(CGSize)contentSizeInPopWhenLandscape {
	if (!CGSizeEqualToSize(contentSizeInPopWhenLandscape, CGSizeZero) && HW_FLOAT_VALUE_IS_ZERO(contentSizeInPopWhenLandscape.width)) {
		switch ([UIApplication sharedApplication].statusBarOrientation) {
			case UIInterfaceOrientationLandscapeLeft:
			case UIInterfaceOrientationLandscapeRight:{
				contentSizeInPopWhenLandscape.width = [UIScreen mainScreen].bounds.size.width;
			}
				break;
			default: {
				contentSizeInPopWhenLandscape.width = [UIScreen mainScreen].bounds.size.height;
			}
				break;

		}
	}

	objc_setAssociatedObject(self, @selector(contentSizeInPopWhenLandscape), [NSValue valueWithCGSize:contentSizeInPopWhenLandscape], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HWPopController *)popController {
    HWPopController *popController = objc_getAssociatedObject(self, _cmd);
	return popController;
}

- (void)setPopController:(HWPopController *)popController {
	objc_setAssociatedObject(self, @selector(popController), popController, OBJC_ASSOCIATION_ASSIGN);
}


@end

UIViewController *HWGetTopMostViewController() {
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
	UIViewController *topVC = keyWindow.rootViewController;
	while (topVC.presentedViewController) {
		topVC = topVC.presentedViewController;
	}

	if ([topVC isKindOfClass:[UINavigationController class]]) {
		topVC = ((UINavigationController *) topVC).topViewController;
	}

	if ([topVC isKindOfClass:[UITabBarController class]]) {
		topVC = ((UITabBarController *) topVC).selectedViewController;
	}

	return topVC;
}

@implementation UIViewController (HWPop)

- (HWPopController *)popup {
	 return [self popupWithPopType:HWPopTypeGrowIn dismissType:HWDismissTypeFadeOut position:HWPopPositionCenter inViewController:HWGetTopMostViewController() dismissOnBackgroundTouch:YES];
}

- (HWPopController *)popupWithPopType:(HWPopType)popType dismissType:(HWDismissType)dismissType{
	return [self popupWithPopType:popType dismissType:dismissType position:HWPopPositionCenter];
}

- (HWPopController *)popupWithPopType:(HWPopType)popType
                          dismissType:(HWDismissType)dismissType
							 position:(HWPopPosition)popPosition {
    return [self popupWithPopType:popType dismissType:dismissType position:popPosition inViewController:HWGetTopMostViewController() dismissOnBackgroundTouch:YES];
}

- (HWPopController *)popupWithPopType:(HWPopType)popType
						  dismissType:(HWDismissType)dismissType
							 position:(HWPopPosition)popPosition
			 dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch {
	return [self popupWithPopType:popType dismissType:dismissType position:popPosition inViewController:HWGetTopMostViewController() dismissOnBackgroundTouch:shouldDismissOnBackgroundTouch];
}

- (HWPopController *)popupWithPopType:(HWPopType)popType
						  dismissType:(HWDismissType)dismissType
                             position:(HWPopPosition)popPosition
					 inViewController:(UIViewController *)inViewController
			 dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch {
	HWPopController *popController = [[HWPopController alloc] initWithViewController:self];
	popController.popType = popType;
	popController.dismissType = dismissType;
	popController.popPosition = popPosition;
	popController.shouldDismissOnBackgroundTouch = shouldDismissOnBackgroundTouch;
	[popController presentInViewController:inViewController];
    return popController;
}

@end
