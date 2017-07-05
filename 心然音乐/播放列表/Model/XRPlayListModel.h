//
//  XRPlayListModel.h
//  心然音乐
//
//  Created by brave on 2017/6/28.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRPlayListModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *singleImageURL;
@property (nonatomic, copy) NSString *albumImageURL;

/** 当前播放的时长 */
@property(nonatomic ,assign) NSTimeInterval costTime;

/** 当前播放总时长 */
@property(nonatomic ,assign) NSTimeInterval totalTime;

/** 当前的播放状态 */
@property(nonatomic ,assign) BOOL isPlaying;

@end
