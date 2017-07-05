//
//  XRPlayListToolBar.h
//  心然音乐
//
//  Created by brave on 2017/6/28.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRPlayListToolBar : UIToolbar

@property (nonatomic, copy) NSString *LRCText;

- (void)updatePlayState:(BOOL)isPlaying;

@end
