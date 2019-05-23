//
//  HWDefaultPopAnimator.h
//  HWPopController
//
//  Created by heath wang on 2019/5/22.
//

#import <Foundation/Foundation.h>
#import <HWPopController/HWPopControllerAnimationProtocol.h>
#import <HWPopController/HWPopController.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWDefaultPopAnimator : NSObject <HWPopControllerAnimationProtocol>

@property (nonatomic, assign) HWPopType popType;
@property (nonatomic, assign) HWDismissType dismissType;

@end

NS_ASSUME_NONNULL_END
