//
//  XRPlaySington.h
//  心然音乐
//
//  Created by brave on 2017/7/4.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRPlayListModel.h"
#import "XRLRCAnalysiser.h"

@protocol XRPlaySingtonDelegate <NSObject>

@required
//- (void)updateWithRow:(NSInteger)row LRCText:(NSString *)LRCText;
- (void)updateWithRow:(NSInteger)row LRCModel:(XRLRCModel *)LRCModel;

@end

@interface XRPlaySington : NSObject

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, assign) NSInteger currentPlayIndex;

/** 负责更新歌词的定时器 */
@property (nonatomic, strong) CADisplayLink *LrcLink;
@property (nonatomic, strong) NSArray *LRCModels;


@property (nonatomic, strong) XRPlayListModel *playModel;
@property (nonatomic, weak) id<XRPlaySingtonDelegate>updateDdelegate;

@property (nonatomic, strong) NSArray <XRPlayListModel *> *playList;


+ (instancetype)sharedInstance;

+ (void)play;
+ (void)pause;
+ (void)stop;

+ (void)next;
+ (void)prior;

@end
