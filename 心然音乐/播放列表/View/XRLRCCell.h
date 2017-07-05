//
//  XRLRCCell.h
//  心然音乐
//
//  Created by brave on 2017/7/3.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRLRCModel.h"
#import "XRLRCLabel.h"

@interface XRLRCCell : UITableViewCell

@property (nonatomic, strong) XRLRCModel *LRCModel;
@property (nonatomic, assign) BOOL highLight;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 歌词进度 */
@property(nonatomic, assign) CGFloat progress;

@end
