//
//  HWViewController.m
//  HWPopController
//
//  Created by Heath Wang on 05/21/2019.
//  Copyright (c) 2019 Heath Wang. All rights reserved.
//

#import "HWViewController.h"
#import <Masonry/Masonry.h>
#import "HWFullDialogViewController.h"
#import <HWPopController/HWPop.h>
#import "HWTopBarViewController.h"
#import "HWBottomAuthViewController.h"
#import "HWCenterViewController.h"
#import "HWAnimationConfigListViewController.h"
#import "HWAutoSizeViewController.h"
#import "HWNavViewController.h"
#import "HWNavStackViewController.h"

@interface HWViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titles;

@end

@implementation HWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            HWAnimationConfigListViewController *animationConfigListViewController = [HWAnimationConfigListViewController new];
            [self.navigationController pushViewController:animationConfigListViewController animated:YES];
        }
            break;
        case 1:{
            HWBottomAuthViewController *bottomAuthVC = [HWBottomAuthViewController new];
            HWPopController *popController = [[HWPopController alloc] initWithViewController:bottomAuthVC];
            popController.popPosition = HWPopPositionBottom;
            popController.popType = HWPopTypeBounceInFromBottom;
            popController.dismissType = HWDismissTypeSlideOutToBottom;
            popController.shouldDismissOnBackgroundTouch = NO;
            [popController presentInViewController:self];
        }
            break;
        case 2:{
            HWTopBarViewController *topBarVC = [HWTopBarViewController new];
            HWPopController *popController = [[HWPopController alloc] initWithViewController:topBarVC];
            popController.backgroundAlpha = 0;
            popController.popPosition = HWPopPositionTop;
            popController.popType = HWPopTypeBounceInFromTop;
            popController.dismissType = HWDismissTypeSlideOutToTop;
            [popController presentInViewController:self];
        }
            break;
        case 3:{
            HWFullDialogViewController *fullDialogViewController = [HWFullDialogViewController new];
            [fullDialogViewController popupWithPopType:HWPopTypeShrinkIn dismissType:HWDismissTypeSlideOutToBottom];
        }
            break;
        case 4:{
            HWCenterViewController *centerViewController = [HWCenterViewController new];
            [centerViewController popup];
        }
            break;
        case 5:{
            HWAutoSizeViewController *autoSizeVC = [HWAutoSizeViewController new];
            [autoSizeVC popup];
        }
            break;
        case 6:{
            HWNavViewController *navVC = [[HWNavViewController alloc] initWithRootViewController:[HWNavStackViewController new]];
            [navVC popupWithPopType:HWPopTypeSlideInFromTop dismissType:HWDismissTypeSlideOutToBottom];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = 55;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];

        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"Pop Animation Style", @"Bottom Sheet", @"Top Bar", @"Full Dialog", @"Center", @"AutoSize", @"Navigation"];
    }
    return _titles;
}


@end

