//
//  HWPickTypeViewController.m
//  HWPopController_Example
//
//  Created by heath wang on 2019/5/24.
//  Copyright © 2019 heathwang. All rights reserved.
//

#import "HWPickTypeViewController.h"
#import "HWAnimationConfigListViewController.h"

@interface HWPickTypeViewController ()

@end

@implementation HWPickTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if (self.pickType == HWPickTypePosition) {
        rows = 3;
    } else {
        rows = 13;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    switch (self.pickType) {
        case HWPickTypePop:{
            cell.textLabel.text = stringWithPopType((HWPopType) indexPath.row);
        }
            break;
        case HWPickTypeDismiss:{
            cell.textLabel.text = stringWithDismissType((HWDismissType) indexPath.row);
        }
            break;
        case HWPickTypePosition:{
            cell.textLabel.text = stringWithPositionType((HWPopPosition) indexPath.row);
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(pickTypeViewController:currentType:pickValue:)]) {
            [self.delegate pickTypeViewController:self currentType:self.pickType pickValue:indexPath.row];
        }
    });
    
}


@end
