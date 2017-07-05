//
//  XRPlayListToolBar.m
//  心然音乐
//
//  Created by brave on 2017/6/28.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlayListToolBar.h"

@interface XRPlayListToolBar ()

@property (nonatomic, strong) UIImageView *albumImageView;
@property (nonatomic, strong) UILabel *lyricsLabel;
@property (nonatomic, strong) UIButton *playPauseBtn;
@property (nonatomic, strong) UIButton *playNextBtn;

@property (nonatomic, assign, getter=isPlaying) BOOL playing;
@end

@implementation XRPlayListToolBar


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
        
    }
    
    return self;
}

- (void)loadSubViews {
    
    self.albumImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_playlistToobar_album"]];
//    self.albumImageView.image = [UIImage imageNamed:@"btn_playlistToobar_album@2x"];
    [self addSubview:self.albumImageView];
    
    self.lyricsLabel = [[UILabel alloc] init];
    self.lyricsLabel.textColor = XRColor(0);
    self.lyricsLabel.font = XRFont(12);
    self.lyricsLabel.text = @"心然音乐 为之心动";
    self.lyricsLabel.textAlignment = NSTextAlignmentCenter;
    self.lyricsLabel.numberOfLines = 0;
    [self addSubview:self.lyricsLabel];
    
    self.playPauseBtn = [[UIButton alloc] init];
    [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_pause"] forState:UIControlStateNormal];
    [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_pause_dis"] forState:UIControlStateDisabled];
    [self.playPauseBtn addTarget:self action:@selector(playPauseBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playPauseBtn];
    
    self.playNextBtn = [[UIButton alloc] init];
    [self.playNextBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_next"] forState:UIControlStateNormal];
    [self.playNextBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_next_dis"] forState:UIControlStateDisabled];
    [self addSubview:self.playNextBtn];
    
}

- (void)playPauseBtnEvent {
    
    self.playing = !self.isPlaying;
    
    if (self.playing) {
        [XRPlaySington play];
    } else {
        [XRPlaySington pause];
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        if (self.isPlaying) {
            [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_play"] forState:UIControlStateNormal];
            [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_play_dis"] forState:UIControlStateDisabled];
        } else {
            [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_pause"] forState:UIControlStateNormal];
            [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_pause_dis"] forState:UIControlStateDisabled];
        }

    }];
    

}

- (void)updatePlayState:(BOOL)isPlaying {
    self.playing = isPlaying;
    
    if (self.isPlaying) {
        [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_play"] forState:UIControlStateNormal];
        [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_play_dis"] forState:UIControlStateDisabled];
    } else {
        [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_pause"] forState:UIControlStateNormal];
        [self.playPauseBtn setImage:[UIImage imageNamed:@"btn_playlistToobar_pause_dis"] forState:UIControlStateDisabled];
    }
    
//    self.lyricsLabel.text = [XRPlaySington sharedInstance].playModel.name;
    
}


- (void)setLRCText:(NSString *)LRCText {
    _LRCText = LRCText;
    
    self.lyricsLabel.text = LRCText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.albumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
//        make.bottom.equalTo(@0);
        make.width.equalTo(@49);
        make.height.equalTo(@49);
    }];
    
    [self.playNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.playPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.playNextBtn.mas_left).offset(-5);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.lyricsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.albumImageView.mas_right).offset(5);
        make.top.equalTo(@2);
        make.bottom.equalTo(@-2);
        make.right.equalTo(self.playPauseBtn.mas_left).offset(5);
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
