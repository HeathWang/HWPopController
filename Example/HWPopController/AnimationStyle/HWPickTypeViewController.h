//
//  HWPickTypeViewController.h
//  HWPopController_Example
//
//  Created by heath wang on 2019/5/24.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWPickTypeViewController;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HWPickType) {
    HWPickTypePop,
    HWPickTypeDismiss,
    HWPickTypePosition,
};

@protocol HWPickTypeViewControllerDelegate <NSObject>

- (void)pickTypeViewController:(HWPickTypeViewController *)pickTypeVC currentType:(HWPickType)pickType pickValue:(NSInteger)pickValue;

@end

@interface HWPickTypeViewController : UITableViewController

@property (nonatomic, assign) HWPickType pickType;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<HWPickTypeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
