//
//  XRPlayLyricsView.h
//  心然音乐
//
//  Created by brave on 2017/6/29.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRLRCModel.h"
@interface XRPlayLyricsView : UIView

/** 外界传递过来的歌词数据源, 负责展示 */
@property (nonatomic, strong) NSArray <XRLRCModel *> *LRCModels;

/** 根据外界传递过来的行号, 负责滚动 */
@property (nonatomic, assign) NSInteger scrollRow;

/** 根据外界传递过来的歌词进度, 展示歌词进度 */
@property (nonatomic, assign) CGFloat progress;

@end
