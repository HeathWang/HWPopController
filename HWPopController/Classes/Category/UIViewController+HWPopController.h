//
//  UIViewController+HWPopController.h
//  HWPopController
//
//  Created by heath wang on 2019/5/21.
//

#import <UIKit/UIKit.h>
#import <HWPopController/HWPopController.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HWPopController)

/**
 * pop size for portrait orientation.
 */
@property (nonatomic, assign) IBInspectable CGSize contentSizeInPop;
/**
 * pop size for landscape orientation
 */
@property (nonatomic, assign) IBInspectable CGSize contentSizeInPopWhenLandscape;

/**
 * The pop ViewController referred HWPopController
 */
@property (nullable, nonatomic, weak, readonly) HWPopController *popController;

@end

@interface UIViewController (HWPop)

/**
 * The controller which will be pop call this method to popup.
 * Use default param.
 * @return HWPopController
 */
- (HWPopController *)popup;

/**
 * The controller which will be pop call this method to popup.
 * @param popType pop animation style
 * @param dismissType dismiss animation style
 * @return HWPopController
 */
- (HWPopController *)popupWithPopType:(HWPopType)popType dismissType:(HWDismissType)dismissType;

/**
 * The controller which will be pop call this method to popup.
 * @param popType pop animation style
 * @param dismissType dismiss animation style
 * @param shouldDismissOnBackgroundTouch bool
 * @return HWPopController
 */
- (HWPopController *)popupWithPopType:(HWPopType)popType dismissType:(HWDismissType)dismissType dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;

/**
 * The controller which will be pop call this method to popup.
 * @param popType pop animation style
 * @param dismissType dismiss animation style
 * @param inViewController who presents popup
 * @param shouldDismissOnBackgroundTouch bool
 * @return HWPopController
 */
- (HWPopController *)popupWithPopType:(HWPopType)popType dismissType:(HWDismissType)dismissType inViewController:(UIViewController *)inViewController dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;

@end

NS_ASSUME_NONNULL_END
