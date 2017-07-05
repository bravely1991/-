//
//  XRLRCAnalysiser.h
//  心然音乐
//
//  Created by brave on 2017/7/3.
//  Copyright © 2017年 心然. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRLRCModel.h"


@interface XRLRCAnalysiser : NSObject

+ (NSInteger)getRowWithCurrentTime:(NSTimeInterval)currentTime lrcModels:(NSArray<XRLRCModel *> *)lrcModels;
+ (NSArray<XRLRCModel *> *)getLrcModelsWithFileName:(NSString *)fileName;

@end
