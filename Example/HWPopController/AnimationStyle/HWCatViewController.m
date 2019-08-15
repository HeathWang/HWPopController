//
//  HWCatViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/5/24.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import "HWCatViewController.h"
#import <HWPopController/HWPop.h>
#import <Masonry/View+MASAdditions.h>

@interface HWCatViewController ()

@end

@implementation HWCatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"Cat";
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapToDismiss)];
    self.navigationItem.rightBarButtonItem = doneItem;

    self.contentSizeInPop = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 60, 330);
    self.contentSizeInPopWhenLandscape = CGSizeMake(315, 300);

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cat"]];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapToDismiss) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor colorWithRed:0.000 green:0.590 blue:1.000 alpha:1.00];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 6.f;

    [self.view addSubview:imageView];
    [self.view addSubview:button];

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
    }];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-10);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.mas_equalTo(60);
    }];
}

- (void)didTapToDismiss {
//    [self.popController dismiss];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
