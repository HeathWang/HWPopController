//
//  HWAnimationConfigListViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/5/23.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import "HWAnimationConfigListViewController.h"
#import <Masonry/Masonry.h>
#import "HWCatViewController.h"
#import "HWPickTypeViewController.h"

@interface HWAnimationConfigListViewController () <UITableViewDataSource, UITableViewDelegate, HWPickTypeViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *headTitles;

@property (nonatomic, assign) HWPopType popType;
@property (nonatomic, assign) HWDismissType dismissType;
@property (nonatomic, assign) HWPopPosition position;

@end

@implementation HWAnimationConfigListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Animation Style";
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = stringWithPopType(self.popType);
            break;
        case 1:
            cell.textLabel.text = stringWithDismissType(self.dismissType);
            break;
        case 2:
            cell.textLabel.text = stringWithPositionType(self.position);
            break;
        default:
            break;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headTitles.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.headTitles[section];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HWPickTypeViewController *pickTypeViewController = [HWPickTypeViewController new];
    pickTypeViewController.pickType = (HWPickType) indexPath.section;
    pickTypeViewController.indexPath = indexPath;
    pickTypeViewController.delegate = self;
    [self.navigationController pushViewController:pickTypeViewController animated:YES];
}

- (void)showPopup {
    HWPopController *popController = [[HWPopController alloc] initWithViewController:[HWCatViewController new]];
    popController.popType = self.popType;
    popController.dismissType = self.dismissType;
    popController.popPosition = self.position;

    [popController presentInViewController:self];
}

#pragma mark - HWPickTypeViewControllerDelegate

- (void)pickTypeViewController:(HWPickTypeViewController *)pickTypeVc currentType:(HWPickType)pickType pickValue:(NSInteger)pickValue {
    switch (pickType) {
        case HWPickTypePop:
            self.popType = (HWPopType) pickValue;
            break;
        case HWPickTypeDismiss:
            self.dismissType = (HWDismissType) pickValue;
            break;
        case HWPickTypePosition:
            self.position = (HWPopPosition) pickValue;
            break;
        default:
            break;
    }

    [self.tableView reloadRowsAtIndexPaths:@[pickTypeVc.indexPath] withRowAnimation:UITableViewRowAnimationRight];
}


#pragma mark - Getter


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = 60;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];

        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 56)];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, 0, CGRectGetWidth(footer.bounds) - 60, 56);
        [button setTitle:@"Pop up" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showPopup) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor colorWithRed:0.000 green:0.590 blue:1.000 alpha:1.00];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 6.f;

        [footer addSubview:button];
        _tableView.tableFooterView = footer;

        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)headTitles {
    if (!_headTitles) {
        _headTitles = @[@"Pop Style", @"Dismiss Style", @"Pop Position"];
    }
    return _headTitles;
}

@end
