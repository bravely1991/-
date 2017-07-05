//
//  XRPlayMainView.h
//  心然音乐
//
//  Created by brave on 2017/6/29.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRPlayMainView : UIView

@property (nonatomic, copy) NSString *LRCText;

- (void)beginRotation;
- (void)pauseRotation;
- (void)resumeRotation;

@end

#import <QuartzCore/QuartzCore.h>

@interface CALayer (PauseAimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;

@end
