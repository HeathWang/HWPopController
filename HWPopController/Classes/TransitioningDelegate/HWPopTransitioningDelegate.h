//
//  HWPopTransitioningDelegate.h
//  HWPopController
//
//  Created by heath wang on 2019/5/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <HWPopController/HWPopController.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWPopTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak, readonly) HWPopController *popController;

- (instancetype)initWithPopController:(HWPopController *)popController NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
