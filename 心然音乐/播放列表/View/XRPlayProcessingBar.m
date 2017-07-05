//
//  XRPlayProcessingBar.m
//  心然音乐
//
//  Created by brave on 2017/7/3.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlayProcessingBar.h"

@interface XRPlayProcessingBar ()

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *beginTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;


@end

@implementation XRPlayProcessingBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
        
    }
    
    return self;
}

- (void)loadSubViews {
    
    self.beginTimeLabel = [[UILabel alloc] init];
    self.beginTimeLabel.font = XRFont(12);
    self.beginTimeLabel.textColor = XRColor(0);
    self.beginTimeLabel.text = @"00:00";
    self.beginTimeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.beginTimeLabel];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.progress = 0;
    [self addSubview:self.progressView];
    
    self.endTimeLabel = [[UILabel alloc] init];
    self.endTimeLabel.font = XRFont(12);
    self.endTimeLabel.textColor = XRColor(0);
    self.endTimeLabel.text = @"00:00";
    self.endTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.endTimeLabel];
    
}
- (void)setTotalTime:(NSTimeInterval)totalTime {
    
    NSInteger minutes = totalTime/60;
    NSInteger seconds = totalTime - minutes * 60;
    NSString *end = [NSString stringWithFormat:@"%02d:%02d", (int)minutes,(int)seconds];
    self.endTimeLabel.text = end;
}

- (void)updatePlayProcessView:(NSTimeInterval)beginTime endTime:(NSTimeInterval)endTime {
    NSInteger minutes = beginTime/60;
    NSInteger seconds = beginTime - minutes * 60;
    NSString *begin = [NSString stringWithFormat:@"%02d:%02d", (int)minutes,(int)seconds];
    self.beginTimeLabel.text = begin;
    
    self.progressView.progress = beginTime/endTime;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beginTimeLabel.mas_right).offset(5);
        make.right.equalTo(self.endTimeLabel.mas_left).offset(-5);
        make.height.equalTo(@2);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
