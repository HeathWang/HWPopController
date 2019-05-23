//
//  NSObject+HWAdd.h
//  HWPopController
//
//  Created by heath wang on 2019/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HWAdd)

+ (BOOL)hw_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)hw_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;
@end

NS_ASSUME_NONNULL_END
