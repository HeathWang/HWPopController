//
//  HWPopNavigationController.m
//  HWPopController
//
//  Created by heath wang on 2019/6/10.
//

#import "HWPopNavigationController.h"
#import "HWNavAnimatedTransitioning.h"
#import "UIViewController+HWPopController.h"

@interface HWPopNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) HWNavAnimatedTransitioning *animatedTransitioning;

@property (nonatomic, assign) CGSize originContentSizeInPop;
@property (nonatomic, assign) CGSize originContentSizeInPopWhenLandscape;

@end

@implementation HWPopNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.originContentSizeInPop = self.contentSizeInPop;
    self.originContentSizeInPopWhenLandscape = self.contentSizeInPopWhenLandscape;
}

#pragma mark - overwrite

- (void)adjustContentSizeBy:(UIViewController *)controller {

    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight: {
            CGSize contentSize = controller.contentSizeInPopWhenLandscape;
            if (!CGSizeEqualToSize(contentSize, CGSizeZero)) {
                self.contentSizeInPopWhenLandscape = contentSize;
            } else {
                self.contentSizeInPopWhenLandscape = self.originContentSizeInPopWhenLandscape;
            }
        }
            break;
        default: {
            CGSize contentSize = controller.contentSizeInPop;
            if (!CGSizeEqualToSize(contentSize, CGSizeZero)) {
                self.contentSizeInPop = contentSize;
            } else {
                self.contentSizeInPop = self.originContentSizeInPop;
            }
        }
            break;
    }

}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    // call this to perform viewDidLoad
    [toVC view];
    [self adjustContentSizeBy:toVC];
    self.animatedTransitioning.state = operation == UINavigationControllerOperationPush ? HWPopStatePop : HWPopStateDismiss;
    return self.animatedTransitioning;
}

#pragma mark - Getter


- (HWNavAnimatedTransitioning *)animatedTransitioning {
    if (!_animatedTransitioning) {
        _animatedTransitioning = [[HWNavAnimatedTransitioning alloc] initWithState:HWPopStatePop];
    }
    return _animatedTransitioning;
}

@end
