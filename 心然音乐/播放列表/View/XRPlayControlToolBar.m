//
//  XRPlayControlToolBar.m
//  心然音乐
//
//  Created by brave on 2017/6/29.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlayControlToolBar.h"
#import "XRPlayProcessingBar.h"



@interface XRPlayControlToolBar ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) XRPlayProcessingBar *progressView;
@property (nonatomic, strong) UIButton *priorBtn;
@property (nonatomic, strong) UIButton *playPauseBtn;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, assign, getter=isPlaying) BOOL playing;

@end


@implementation XRPlayControlToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
    }
    
    return self;
}

- (void)loadSubViews {
    self.progressView = [[XRPlayProcessingBar alloc] init];
    [self addSubview:self.progressView];
    
    self.priorBtn = [[UIButton alloc] init];
    [self.priorBtn setImage:[UIImage imageNamed:@"btn_playControl_prior_h"] forState:UIControlStateHighlighted];
    [self.priorBtn setImage:[UIImage imageNamed:@"btn_playControl_prior"] forState:UIControlStateNormal];
    [self.priorBtn addTarget:self action:@selector(priorBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.priorBtn];
    
    self.playPauseBtn = [[UIButton alloc] init];
    [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_pause_h"] forState:UIControlStateHighlighted];
    [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_pause"] forState:UIControlStateNormal];
    [self.playPauseBtn addTarget:self action:@selector(playPauseBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playPauseBtn];
    
    self.nextBtn = [[UIButton alloc] init];
    [self.nextBtn setImage:[UIImage imageNamed:@"btn_playControl_next_h"] forState:UIControlStateHighlighted];
    [self.nextBtn setImage:[UIImage imageNamed:@"btn_playControl_next"] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.nextBtn];
    
}

- (void)playPauseBtnEvent {
    
    [UIView animateWithDuration:0.5f animations:^{
        if (self.isPlaying) {
            [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_pause"] forState:UIControlStateNormal];
            [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_pause_h"] forState:UIControlStateDisabled];

        } else {
            [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_play_h"] forState:UIControlStateHighlighted];
            [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_play"] forState:UIControlStateNormal];
        }
    }];

    self.playing = !self.isPlaying;
    
    if (self.isPlaying) {
        [XRPlaySington play];
    }else {
        [XRPlaySington pause];
    }
    
    if (self.XRDelegate && [self.XRDelegate respondsToSelector:@selector(playPauseBtnEvent:)] ) {
        [self.XRDelegate playPauseBtnEvent:self.isPlaying];
    }
    
}

- (void)nextBtnEvent {
    [XRPlaySington next];

    if (self.XRDelegate && [self.XRDelegate respondsToSelector:@selector(nextBtnEvent)]) {
        [self.XRDelegate nextBtnEvent];
    }
}

- (void)priorBtnEvent {
    [XRPlaySington prior];

    if (self.XRDelegate && [self.XRDelegate respondsToSelector:@selector(priorBtnEvent)]) {
        [self.XRDelegate priorBtnEvent];
    }
}

- (void)setTotalTime:(NSTimeInterval)totalTime {
    [self.progressView setTotalTime:totalTime];
}

- (void)updatePlayProcessView:(NSTimeInterval)beginTime endTime:(NSTimeInterval)endTime {
    [self.progressView updatePlayProcessView:beginTime endTime:endTime];
}

- (void)updatePlayState:(BOOL)isPlaying {
    self.playing = isPlaying;
    
    if (self.isPlaying) {
        [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_play_h"] forState:UIControlStateHighlighted];
        [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_play"] forState:UIControlStateNormal];
    } else {
        [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_pause"] forState:UIControlStateNormal];
        [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playControl_pause_h"] forState:UIControlStateDisabled];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
    [self.playPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView.mas_bottom).offset(0);
        make.width.equalTo(@64);
        make.height.equalTo(@64);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.priorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@64);
        make.height.equalTo(@64);
        make.centerY.equalTo(self.playPauseBtn.mas_centerY);
        make.left.equalTo(@50);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@64);
        make.height.equalTo(@64);
        make.centerY.equalTo(self.playPauseBtn.mas_centerY);
        make.right.equalTo(@-50);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
