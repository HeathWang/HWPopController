//
//  HWFullDialogViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/5/23.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import "HWFullDialogViewController.h"
#import <HWPopController/HWPop.h>
#import <Masonry/Masonry.h>

@interface HWFullDialogViewController ()

@property (nonatomic, strong) UIView *centerDialog;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation HWFullDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentSizeInPop = [UIScreen mainScreen].bounds.size;
    self.popController.containerView.backgroundColor = [UIColor clearColor];
    [self setupView];

}

- (void)setupView {
    [self.view addSubview:self.centerDialog];
    [self.centerDialog addSubview:self.tipsLabel];
    [self.view addSubview:self.closeButton];
    [self setupViewConstraints];
}

- (void)setupViewConstraints {
    [self.centerDialog mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@-30);
        make.centerY.equalTo(@0);
        make.height.mas_equalTo(300);
    }];

    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointZero);
    }];

    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.centerDialog.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
}

- (void)didTapToClose {
    [self dismissViewControllerAnimated:YES completion:^{

    }];

    // this code also can dismiss
//    [self.popController dismiss];
}

#pragma mark - Getter

- (UIView *)centerDialog {
    if (!_centerDialog) {
        _centerDialog = [UIView new];
        _centerDialog.backgroundColor = [UIColor colorWithRed:0.448 green:0.846 blue:0.906 alpha:1.00];
        _centerDialog.layer.cornerRadius = 6;
    }
    return _centerDialog;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel new];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.font = [UIFont boldSystemFontOfSize:20];
        _tipsLabel.text = @"Make your own UI.";
    }
    return _tipsLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"btn_close_circle_white"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(didTapToClose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}


@end
