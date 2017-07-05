//
//  XRPlayMainView.m
//  心然音乐
//
//  Created by brave on 2017/6/29.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlayMainView.h"

@interface XRPlayMainView ()

@property (nonatomic, strong) UIImageView *singerImageView;
@property (nonatomic, strong) UILabel *lyricsLabel;

@end

@implementation CALayer (PauseAimate)

- (void)pauseAnimate
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)resumeAnimate
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end



@implementation XRPlayMainView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor clearColor];
        
        [self loadSubViews];
        
    }
    
    return self;
}

- (void)loadSubViews {
    
    self.singerImageView = [[UIImageView alloc] init];
    self.singerImageView.image = [UIImage imageNamed:@"yuanjuxinran"];
    [self addSubview:self.singerImageView];
    
    
    self.lyricsLabel = [[UILabel alloc] init];
    self.lyricsLabel.font = XRFont(14);
    self.lyricsLabel.textAlignment = NSTextAlignmentCenter;
    self.lyricsLabel.textColor = XRColorRGB(0, 255, 0);
    self.lyricsLabel.numberOfLines = 0;
    self.lyricsLabel.text = @"心然音乐-为之心动";
    [self addSubview:self.lyricsLabel];

    [self beginRotation];
    [self pauseRotation];
}

- (void)setLRCText:(NSString *)LRCText {
    _LRCText = LRCText;
    
    self.lyricsLabel.text = LRCText;
}


/**
 *  开始旋转
 */
- (void)beginRotation
{
    [self.singerImageView.layer removeAnimationForKey:@"rotation"];
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    animation.duration = 30;
    animation.keyPath = @"transform.rotation.z";
    animation.repeatCount = NSIntegerMax;
    animation.removedOnCompletion = NO;
    [self.singerImageView.layer addAnimation:animation forKey:@"rotation"];
}

/**
 *  暂停旋转(此处的实现, 是使用到了一个CALayer分类, 来暂停核心动画)
 */
- (void)pauseRotation
{
    [self.singerImageView.layer pauseAnimate];
}

/**
 *  继续旋转(此处的实现, 是使用到了一个CALayer分类, 来暂停核心动画)
 */
- (void)resumeRotation
{
    [self.singerImageView.layer resumeAnimate];
}




- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.singerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.height.equalTo(self.singerImageView.mas_width);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.lyricsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@-10);
    }];
    
    
    self.singerImageView.layer.cornerRadius = (XRWidth-100)/2.0;
    self.singerImageView.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
