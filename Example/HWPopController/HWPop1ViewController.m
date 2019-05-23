//
//  HWPop1ViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/5/22.
//  Copyright © 2019 wangcongling. All rights reserved.
//

#import "HWPop1ViewController.h"
#import <HWPopController/HWPop.h>

@interface HWPop1ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end

@implementation HWPop1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentSizeInPop = CGSizeMake(250, 300);
    
    self.view.backgroundColor = [UIColor purpleColor];

    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField.delegate = self;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.textField.frame = CGRectMake(10, CGRectGetHeight(self.view.bounds) - 40, CGRectGetWidth(self.view.bounds) - 20, 40);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

@end
