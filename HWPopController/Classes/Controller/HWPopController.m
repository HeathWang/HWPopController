//
//  HWPopController.m
//  HWPopController
//
//  Created by heath wang on 2019/5/21.
//

#import "HWPopController.h"
#import "UIViewController+HWPopController.h"
#import "HWPopTransitioningDelegate.h"

static NSMutableSet *_retainedPopControllers;

@interface UIViewController (Internal)

@property (nonatomic, weak) HWPopController *popController;

@end

@interface HWPopContainerViewController : UIViewController

@end

@implementation HWPopContainerViewController

@end

@interface HWPopController ()

@property (nonatomic, strong) HWPopContainerViewController *containerViewController;
@property (nonatomic, strong) UIViewController *topViewController;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) BOOL didOverrideSafeAreaInsets;
@property (nonatomic, assign) BOOL isObserving;

@property (nonatomic, copy) NSDictionary *keyboardInfo;

@property (nonatomic, strong) HWPopTransitioningDelegate *transitioningDelegate;

@end

@implementation HWPopController

#pragma mark - init

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _retainedPopControllers = [NSMutableSet set];
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - public method

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [self init];
    if (self) {
        self.topViewController = viewController;
        // set popController to the popped viewController
        viewController.popController = self;
        [self setupObserverForViewController:viewController];
    }
    return self;
}

- (void)presentInViewController:(UIViewController *)presentingViewController {
    [self presentInViewController:presentingViewController completion:nil];
}

- (void)presentInViewController:(UIViewController *)presentingViewController completion:(nullable void (^)(void))completion {
    if (self.presented)
        return;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupObserver];
        [_retainedPopControllers addObject:self];
        
        UIViewController *VC = presentingViewController.tabBarController ?: presentingViewController;
        
        if (@available(iOS 11.0, *)) {
            if (!self.didOverrideSafeAreaInsets) {
                self.safeAreaInsets = presentingViewController.view.safeAreaInsets;
            }
        }
        
        [VC presentViewController:self.containerViewController animated:YES completion:completion];
    });
}

- (void)dismiss {
    [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(nullable void (^)(void))completion {
    if (!self.presented)
        return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self destroyObserver];
        [self.containerViewController dismissViewControllerAnimated:YES completion:^{
            [_retainedPopControllers removeObject:self];
            completion ? completion() : nil;
        }];
    });
}

#pragma mark - observe

- (void)setupObserverForViewController:(UIViewController *)viewController {
    [viewController addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSizeInPop)) options:NSKeyValueObservingOptionNew context:nil];
    [viewController addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSizeInPopWhenLandscape)) options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setupObserver {
    if (self.isObserving)
        return;

    // Observe orientation change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

    // Observe keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.isObserving = YES;
}

- (void)destroyObserver {
    if (!self.isObserving)
        return;

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.isObserving = NO;
}

- (void)destroyObserverOfViewController:(UIViewController *)viewController {
    [viewController removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSizeInPop))];
    [viewController removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSizeInPopWhenLandscape))];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    if (object == self.topViewController) {
        if (self.topViewController.isViewLoaded && self.topViewController.view.superview) {
            [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                [self layoutContainerView];
            } completion:^(BOOL finished) {
                [self adjustContainerViewOrigin];
            }];
        }
    }
}

#pragma mark - UIApplicationDidChangeStatusBarOrientationNotification

- (void)orientationDidChange {
    [self.containerView endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutContainerView];
    } completion:^(BOOL finished) {

    }];
}

#pragma mark - keyboard handle

- (void)adjustContainerViewOrigin {

    if (!self.keyboardInfo)
        return;

    UIView <UIKeyInput> *currentTextInput = [self getCurrentTextInputInView:self.containerView];
    if (!currentTextInput) {
        return;
    }

    CGAffineTransform lastTransform = self.containerView.transform;
    self.containerView.transform = CGAffineTransformIdentity;

    CGFloat textFieldBottomY = [currentTextInput convertPoint:CGPointZero toView:self.containerViewController.view].y + currentTextInput.bounds.size.height;
    CGFloat keyboardHeight = [self.keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // For iOS 7
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 &&
            (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)) {
        keyboardHeight = [self.keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.width;
    }

    CGFloat offsetY = 0;
    if (self.popPosition == HWPopPositionBottom) {
        offsetY = keyboardHeight - _safeAreaInsets.bottom;
    } else {
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        if (self.containerView.bounds.size.height <= self.containerViewController.view.bounds.size.height - keyboardHeight - statusBarHeight) {
            offsetY = self.containerView.frame.origin.y - (statusBarHeight + (self.containerViewController.view.bounds.size.height - keyboardHeight - statusBarHeight - self.containerView.bounds.size.height) / 2);
        } else {
            CGFloat spacing = 5;
            offsetY = self.containerView.frame.origin.y + self.containerView.bounds.size.height - (self.containerViewController.view.bounds.size.height - keyboardHeight - spacing);
            if (offsetY <= 0) { // self.containerView can be totally shown, so no need to translate the origin
                return;
            }
            if (self.containerView.frame.origin.y - offsetY < statusBarHeight) { // self.containerView will be covered by status bar if the origin is translated by "offsetY"
                offsetY = self.containerView.frame.origin.y - statusBarHeight;
                // currentTextField can not be totally shown if self.containerView is going to repositioned with "offsetY"
                if (textFieldBottomY - offsetY > self.containerViewController.view.bounds.size.height - keyboardHeight - spacing) {
                    offsetY = textFieldBottomY - (self.containerViewController.view.bounds.size.height - keyboardHeight - spacing);
                }
            }
        }
    }

    NSTimeInterval duration = [self.keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [self.keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];

    self.containerView.transform = lastTransform; // Restore transform

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDuration:duration];

    self.containerView.transform = CGAffineTransformMakeTranslation(0, -offsetY);

    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    UIView <UIKeyInput> *currentTextInput = [self getCurrentTextInputInView:self.containerView];
    if (!currentTextInput) {
        return;
    }

    self.keyboardInfo = notification.userInfo;
    [self adjustContainerViewOrigin];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.keyboardInfo = nil;

    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDuration:duration];

    self.containerView.transform = CGAffineTransformIdentity;

    [UIView commitAnimations];
}

- (UIView <UIKeyInput> *)getCurrentTextInputInView:(UIView *)view {
    if ([view conformsToProtocol:@protocol(UIKeyInput)] && view.isFirstResponder) {
        // Quick fix for web view issue
        if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")] || [view isKindOfClass:NSClassFromString(@"WKContentView")]) {
            return nil;
        }
        return (UIView <UIKeyInput> *) view;
    }

    for (UIView *subview in view.subviews) {
        UIView <UIKeyInput> *inputInView = [self getCurrentTextInputInView:subview];
        if (inputInView) {
            return inputInView;
        }
    }
    return nil;
}

#pragma mark - touch event

- (void)didTapBackgroundView {
    if (self.shouldDismissOnBackgroundTouch) {
        [self dismiss];
    }
}

#pragma mark - UI Layout

- (void)layoutContainerView {
    CGAffineTransform lastTransform = self.containerView.transform;
    self.containerView.transform = CGAffineTransformIdentity;

    self.backgroundView.frame = self.containerViewController.view.bounds;

    CGSize contentSizeOfTopView = [self contentSizeOfTopView];
    CGFloat containerViewWidth = contentSizeOfTopView.width;
    CGFloat containerViewHeight = contentSizeOfTopView.height;
    CGFloat containerViewY;

    switch (self.popPosition) {
        case HWPopPositionBottom:{
            containerViewHeight += _safeAreaInsets.bottom;
            containerViewY = self.containerViewController.view.bounds.size.height - containerViewHeight;
        }
            break;
        case HWPopPositionTop:{
            containerViewY = 0;
        }
            break;
        default:{
            containerViewY = (self.containerViewController.view.bounds.size.height - containerViewHeight) / 2;
        }
            break;
    }

    containerViewY += self.positionOffset.y;
    CGFloat containerViewX = (self.containerViewController.view.bounds.size.width - containerViewWidth) / 2 + self.positionOffset.x;
    self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewWidth, containerViewHeight);
    self.contentView.frame = CGRectMake(0, 0, contentSizeOfTopView.width, contentSizeOfTopView.height);

    UIViewController *topViewController = self.topViewController;
    topViewController.view.frame = self.contentView.bounds;

    self.containerView.transform = lastTransform;
}

- (CGSize)contentSizeOfTopView {
    UIViewController *topViewController = self.topViewController;
    CGSize contentSize;
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight: {
            contentSize = topViewController.contentSizeInPopWhenLandscape;
            if (CGSizeEqualToSize(contentSize, CGSizeZero)) {
                contentSize = topViewController.contentSizeInPop;
            }
        }
            break;
        default: {
            contentSize = topViewController.contentSizeInPop;
        }
            break;
    }

    NSAssert(!CGSizeEqualToSize(contentSize, CGSizeZero), @"contentSizeInPopup should not be size zero.");
    return contentSize;
}

#pragma mark - UI prepare

- (void)setup {
    self.shouldDismissOnBackgroundTouch = YES;
    self.animationDuration = 0.2;
    self.popType = HWPopTypeGrowIn;
    self.dismissType = HWDismissTypeFadeOut;
    
    [self.containerViewController.view addSubview:self.containerView];
    [self.containerView addSubview:self.contentView];

    UIView *bgView = [UIView new];
    self.backgroundView = bgView;
    self.backgroundAlpha = 0.5;
}

#pragma mark - Setter

- (void)setSafeAreaInsets:(UIEdgeInsets)safeAreaInsets {
    _safeAreaInsets = safeAreaInsets;
    self.didOverrideSafeAreaInsets = YES;
}

- (void)setBackgroundView:(UIView *)backgroundView {
    [_backgroundView removeFromSuperview];
    _backgroundView = backgroundView;
    [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBackgroundView)]];
    [self.containerViewController.view insertSubview:_backgroundView atIndex:0];
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    _backgroundAlpha = backgroundAlpha;
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:backgroundAlpha];
}

#pragma mark - Getter

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.clipsToBounds = YES;
        _containerView.layer.cornerRadius = 8;
    }
    return _containerView;
}

- (HWPopContainerViewController *)containerViewController {
    if (!_containerViewController) {
        _containerViewController = [HWPopContainerViewController new];
        _containerViewController.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = [[HWPopTransitioningDelegate alloc] initWithPopController:self];
        _containerViewController.transitioningDelegate = self.transitioningDelegate;
    }
    return _containerViewController;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (BOOL)presented {
    return self.containerViewController.presentingViewController != nil;
}

- (void)dealloc {
    [self destroyObserver];
    [self destroyObserverOfViewController:self.topViewController];
}

@end
