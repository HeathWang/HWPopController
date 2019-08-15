//
//  HWNavStackViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/6/10.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "HWNavStackViewController.h"
#import "HWCatViewController.h"

@interface HWNavStackViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation HWNavStackViewController

- (void)loadView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    self.navigationItem.title = [NSString stringWithFormat:@"Page %ld", (long)index + 1];
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeAction)];
        self.navigationItem.rightBarButtonItem = closeItem;
    }

    [self setupView];
}

- (void)setupView {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:[self nextButton]];
    [self setupViewConstraints];
}

- (void)setupViewConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.centerY.equalTo(@0);
    }];

    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(55);
        make.bottom.equalTo(@0);
    }];
}

#pragma mark - touch action

- (void)nextPage {
    HWCatViewController *catViewController = [HWCatViewController new];
    [self.navigationController pushViewController:catViewController animated:YES];
}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"When you use UINavigationController in HWPopController, You can dynamic change the pop size.";
        _titleLabel.numberOfLines = 0;

    }
    return _titleLabel;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:[UIColor colorWithRed:0.000 green:0.590 blue:1.000 alpha:1.00]];
        _nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 6;
        [_nextButton addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}


@end
