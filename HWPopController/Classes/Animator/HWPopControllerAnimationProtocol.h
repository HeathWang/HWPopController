//
//  HWPopControllerAnimationProtocol.h
//  HWPopController
//
//  Created by heath wang on 2019/5/22.
//

#ifndef HWPopControllerAnimationProtocol_h
#define HWPopControllerAnimationProtocol_h

NS_ASSUME_NONNULL_BEGIN

@class HWPopAnimationContext;

@protocol HWPopControllerAnimationProtocol <NSObject>

- (NSTimeInterval)popControllerAnimationDuration:(HWPopAnimationContext *)context;
- (void)popAnimate:(HWPopAnimationContext *)context completion:(void (^)(BOOL finished))completion;
- (void)dismissAnimate:(HWPopAnimationContext *)context completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END

#endif /* HWPopControllerAnimationProtocol_h */
