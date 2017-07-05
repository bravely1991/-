//
//  XRPlaySington.m
//  心然音乐
//
//  Created by brave on 2017/7/4.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlaySington.h"

@interface XRPlaySington ()<AVAudioPlayerDelegate>



@end



@implementation XRPlaySington

static XRPlaySington * _instance = nil;

+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];

    
    return self;
}

- (void)updateLrc {
    //    NSLog(@"self.player.currentTime:%.2f",self.player.currentTime);
    
    NSInteger row = [XRLRCAnalysiser getRowWithCurrentTime:[XRPlaySington sharedInstance].player.currentTime lrcModels:self.LRCModels];
    
    // 把需要滚动的行号, 交给歌词控制器统一管理, 让歌词控制器负责滚动
    
    //     显示歌词label
    //     取出当前正在播放的歌词数据模型
    XRLRCModel *lrcModel = self.LRCModels[row];
    
    NSLog(@"row:%ld lrc:%@",row,lrcModel.lrcText);
    
    if (self.updateDdelegate && [self.updateDdelegate respondsToSelector:@selector(updateWithRow:LRCModel:)]) {
        [self.updateDdelegate updateWithRow:row LRCModel:lrcModel];
    }
}

- (void)setCurrentPlayIndex:(NSInteger)currentPlayIndex {
    _currentPlayIndex = currentPlayIndex;
    
    XRPlayListModel *playModel = self.playList[currentPlayIndex];
    //不是同一首歌
    if (![self.playModel.name isEqualToString:playModel.name]) {
        _playModel = playModel;
        
        // 根据资源路径, 创建播放器对象
        NSString *filePath = [[NSBundle mainBundle] pathForResource:playModel.filename ofType:@"mp3"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        self.player.numberOfLoops = -1;
        // 设置播放器的代理
        self.player.delegate = self;
        // 开始播放
        [self.player prepareToPlay];
        
        _playModel.totalTime = self.player.duration;
        _playModel.costTime = self.player.currentTime;
    }
    
    self.LRCModels =  [XRLRCAnalysiser getLrcModelsWithFileName:[XRPlaySington sharedInstance].playModel.filename];
    
    self.LrcLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrc)];
    [self.LrcLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.LrcLink setPaused:![XRPlaySington sharedInstance].player.isPlaying];

}


+ (void)play {
    [[XRPlaySington sharedInstance].player play];
    [[XRPlaySington sharedInstance].LrcLink setPaused:NO];
}

+ (void)pause {
    [[XRPlaySington sharedInstance].player pause];
    [[XRPlaySington sharedInstance].LrcLink setPaused:YES];

}

+ (void)stop {
    [[XRPlaySington sharedInstance].player stop];
    [[XRPlaySington sharedInstance].LrcLink invalidate];

}

+ (void)next {
    
    [[XRPlaySington sharedInstance].player stop];
    [[XRPlaySington sharedInstance].LrcLink invalidate];
    
    [XRPlaySington sharedInstance].currentPlayIndex = ([XRPlaySington sharedInstance].currentPlayIndex + 1 ) % [XRPlaySington sharedInstance].playList.count;
    [XRPlaySington play];
}

+ (void)prior {
    
    [[XRPlaySington sharedInstance].player stop];
    [[XRPlaySington sharedInstance].LrcLink invalidate];
    
    [XRPlaySington sharedInstance].currentPlayIndex = ([XRPlaySington sharedInstance].currentPlayIndex - 1 ) % [XRPlaySington sharedInstance].playList.count;
    [XRPlaySington play];

}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag  {
    
}

@end
