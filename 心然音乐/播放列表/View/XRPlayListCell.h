//
//  XRPlayListCell.h
//  心然音乐
//
//  Created by brave on 2017/6/28.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRPlayListModel.h"

@interface XRPlayListCell : UITableViewCell

@property (nonatomic, strong) XRPlayListModel *listModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
