//
//  HWNavViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/6/10.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import "HWNavViewController.h"
#import <HWPopController/HWPop.h>
#import "HWCatViewController.h"

@interface HWNavViewController ()

@end

@implementation HWNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.contentSizeInPop = CGSizeMake(screenSize.width - 60, screenSize.height * 0.6);
    self.contentSizeInPopWhenLandscape = CGSizeMake(screenSize.height - 100, screenSize.width * 0.6);
    
    self.navigationBar.translucent = NO;
}

@end
