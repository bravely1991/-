//
//  XRLRCModel.h
//  心然音乐
//
//  Created by brave on 2017/7/3.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRLRCModel : NSObject

/** 开始时间 */
@property (nonatomic ,assign) NSTimeInterval beginTime;

/** 结束时间 */
@property (nonatomic ,assign) NSTimeInterval endTime;

/** 歌词内容 */
@property (nonatomic ,copy) NSString *lrcText;

- (NSString *)getFormatTimeWithTimeInterval:(NSTimeInterval)timeInterval;
- (NSTimeInterval)getTimeIntervalWithFormatTime:(NSString *)format;

@end
