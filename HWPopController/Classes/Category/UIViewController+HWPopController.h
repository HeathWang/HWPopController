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

- (HWPopController *)popupWithPopType:(HWPopType)popType
                          dismissType:(HWDismissType)dismissType;

- (HWPopController *)popupWithPopType:(HWPopType)popType
                          dismissType:(HWDismissType)dismissType
                             position:(HWPopPosition)popPosition;

- (HWPopController *)popupWithPopType:(HWPopType)popType
                          dismissType:(HWDismissType)dismissType
                             position:(HWPopPosition)popPosition
             dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;

- (HWPopController *)popupWithPopType:(HWPopType)popType
                          dismissType:(HWDismissType)dismissType
                             position:(HWPopPosition)popPosition
                     inViewController:(UIViewController *)inViewController
             dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch;
@end

NS_ASSUME_NONNULL_END
