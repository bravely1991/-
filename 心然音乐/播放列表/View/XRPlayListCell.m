//
//  XRPlayListCell.m
//  心然音乐
//
//  Created by brave on 2017/6/28.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlayListCell.h"


@interface XRPlayListCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *albumLabel;
@property (nonatomic, strong) UIButton *moreButton;


@end

@implementation XRPlayListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * const ID = @"XRPlayListCell";
    XRPlayListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XRPlayListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.backgroundColor = [UIColor clearColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadSubViews];
    }
    
    return cell;
}

- (void)setListModel:(XRPlayListModel *)listModel {
    _listModel = listModel;
    
    self.nameLabel.text = listModel.name;
    self.albumLabel.text = listModel.album;
    
    [self layoutSubview];
}

- (void)loadSubViews {
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = XRFont(14);
    self.nameLabel.textColor = XRColor(222);
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    
    self.albumLabel = [[UILabel alloc] init];
    self.albumLabel.font = XRFont(12);
    self.albumLabel.textColor = XRColor(150);
    self.albumLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.albumLabel];
    
    self.moreButton = [[UIButton alloc] init];
    [self.moreButton setImage:[UIImage imageNamed:@"btn_playlist_more"] forState:UIControlStateNormal];
    [self.moreButton setImage:[UIImage imageNamed:@"btn_playlist_more_h"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:self.moreButton];
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    selectedBackgroundView.backgroundColor = XRColorRGBA(0, 0, 255, 0.3);
    self.selectedBackgroundView = selectedBackgroundView;
    
}

- (void)layoutSubview {
//    [super layoutSubviews];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-50);
        make.top.equalTo(@5);
        make.height.equalTo(@20);
    }];
    
    [self.albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-50);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.equalTo(@20);
//        make.bottom.equalTo(@5);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.right.equalTo(@-20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
