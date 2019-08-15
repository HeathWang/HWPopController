//
//  HWTopBarViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/5/23.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import <HWPopController/HWPop.h>
#import "HWTopBarViewController.h"
#import <Masonry/Masonry.h>

@interface HWTopBarViewController ()

@end

@implementation HWTopBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentSizeInPop = CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 64);
    self.view.backgroundColor = [UIColor colorWithRed:0.397 green:0.859 blue:0.066 alpha:1.00];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapToDismiss)];
    [self.view addGestureRecognizer:tapGestureRecognizer];

    UILabel *label = [UILabel new];
    label.text = @"ME, Like a Notification";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];

    [self.view addSubview:label];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointZero);
    }];
}

- (void)didTapToDismiss {
    [self.popController dismiss];
}



@end
