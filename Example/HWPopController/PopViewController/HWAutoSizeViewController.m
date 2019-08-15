//
//  HWAutoSizeViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/6/6.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import "HWAutoSizeViewController.h"
#import <HWPopController/HWPop.h>
#import <Masonry/Masonry.h>

@interface HWAutoSizeViewController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *growButton;

@end

@implementation HWAutoSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentSizeInPop = CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 80);
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.growButton];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.width.mas_equalTo(self.contentSizeInPop.width);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.top.equalTo(@10);
    }];

    [self.growButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
        make.height.mas_equalTo(46);
        make.top.equalTo(self.label.mas_bottom).offset(20);
    }];
    
    [self.view layoutIfNeeded];
    
    CGFloat height = CGRectGetMaxY(self.growButton.frame) + 10;
    
    self.contentSizeInPop = CGSizeMake(self.contentSizeInPop.width, height);
}

- (void)growAction {
    self.label.text = [NSString stringWithFormat:@"%@%@", self.label.text, @"\nShow Me the Code."];

    [self.view layoutIfNeeded];
    CGFloat height = CGRectGetMaxY(self.growButton.frame) + 10;
    self.contentSizeInPop = CGSizeMake(self.contentSizeInPop.width, height);
}

#pragma mark - Getter

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    
    return _contentView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
        _label.text = @"The UIViewController class defines the shared behavior that is common to all view controllers. You rarely create instances of the UIViewController class directly. Instead, you subclass UIViewController and add the methods and properties needed to manage the view controller's view hierarchy.";
    }
    return _label;
}

- (UIButton *)growButton {
    if (!_growButton) {
        _growButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_growButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_growButton setTitle:@"Grow" forState:UIControlStateNormal];
        [_growButton setBackgroundColor:[UIColor colorWithRed:0.000 green:0.590 blue:1.000 alpha:1.00]];
        _growButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _growButton.layer.masksToBounds = YES;
        _growButton.layer.cornerRadius = 6;
        [_growButton addTarget:self action:@selector(growAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _growButton;
}


@end
