//
//  XRLRCLabel.m
//  心然音乐
//
//  Created by brave on 2017/7/3.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRLRCLabel.h"

@implementation XRLRCLabel

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 设置颜色
    [[UIColor greenColor] set];
    
    CGRect fillRect = CGRectMake(0, 0, rect.size.width * self.progress, rect.size.height);
    
//        UIRectFill(fillRect);
    
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}


@end
