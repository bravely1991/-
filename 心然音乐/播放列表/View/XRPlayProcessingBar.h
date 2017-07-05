//
//  XRPlayProcessingBar.h
//  心然音乐
//
//  Created by brave on 2017/7/3.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRPlayProcessingBar : UIView

- (void)updatePlayProcessView:(NSTimeInterval)beginTime endTime:(NSTimeInterval)endTime;

- (void)setTotalTime:(NSTimeInterval)totalTime;

@end
