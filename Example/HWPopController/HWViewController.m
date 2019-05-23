//
//  HWViewController.m
//  HWPopController
//
//  Created by Heath Wang on 05/21/2019.
//  Copyright (c) 2019 Heath Wang. All rights reserved.
//

#import "HWViewController.h"
#import <HWPopController/HWPopController.h>
#import <HWPopController/HWPop.h>
#import "HWPop1ViewController.h"

@interface HWViewController ()

@end

@implementation HWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	testButton.frame = CGRectMake(44, 84, 60, 40);
    [testButton setTitle:@"TEST" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}

- (void)test {
    HWPop1ViewController *pop1ViewController = [HWPop1ViewController new];
    [pop1ViewController popupWithPopType:HWPopTypeGrowIn dismissType:HWDismissTypeGrowOut dismissOnBackgroundTouch:YES];
    HWPopController *popController = [[HWPopController alloc] initWithRootViewController:pop1ViewController];
    popController.popPosition = HWPopPositionTop;
    [popController presentInViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
