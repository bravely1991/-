//
//  XRLRCCell.m
//  心然音乐
//
//  Created by brave on 2017/7/3.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRLRCCell.h"

@interface XRLRCCell ()

@property (nonatomic, strong) XRLRCLabel *LRCLabel;

@end

@implementation XRLRCCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * const ID = @"XRLRCCell";
    XRLRCCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XRLRCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell loadSubViews];
    }
    
    return cell;
}

- (void)loadSubViews {
    self.LRCLabel = [[XRLRCLabel alloc] init];
    self.LRCLabel.font = XRFont(14);
    self.LRCLabel.textColor = XRColor(255);
    
    self.LRCLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.LRCLabel];
}


- (void)setLRCModel:(XRLRCModel *)LRCModel {
    _LRCModel = LRCModel;
    
    self.LRCLabel.text = LRCModel.lrcText;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.LRCLabel.progress = progress;
    
}

- (void)setHighLight:(BOOL)highLight {
    _highLight = highLight;
    self.LRCLabel.font = highLight ? XRFont(16) : XRFont(14);

}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.LRCLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
    }];
}

@end
