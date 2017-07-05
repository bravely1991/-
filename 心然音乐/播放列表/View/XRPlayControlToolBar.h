//
//  XRPlayControlToolBar.h
//  心然音乐
//
//  Created by brave on 2017/6/29.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XRPlayControlToolBarDelegate <NSObject>

@required
- (void)playPauseBtnEvent:(BOOL)isPlaying;
- (void)priorBtnEvent;
- (void)nextBtnEvent;

@end

@interface XRPlayControlToolBar : UIToolbar

@property (nonatomic, weak) id<XRPlayControlToolBarDelegate>XRDelegate;

- (void)updatePlayProcessView:(NSTimeInterval)beginTime endTime:(NSTimeInterval)endTime;
- (void)setTotalTime:(NSTimeInterval)totalTime;

- (void)updatePlayState:(BOOL)isPlaying;


@end
