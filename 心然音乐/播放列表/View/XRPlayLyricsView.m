//
//  XRPlayLyricsView.m
//  心然音乐
//
//  Created by brave on 2017/6/29.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlayLyricsView.h"
#import "XRLRCAnalysiser.h"
#import "XRLRCCell.h"

@interface XRPlayLyricsView ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XRPlayLyricsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundView.image = [UIImage imageNamed:@"image_playlist_background"];
        [self addSubview:backgroundView];
        
//        self.backgroundColor = [UIColor clearColor];
        
        [self loadSubViews];
        

    }
    
    return self;
}

- (void)loadSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(self.bounds.size.height * 0.5, 0, self.bounds.size.height * 0.5, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
}

- (void)setLRCModels:(NSArray<XRLRCModel *> *)LRCModels {
    _LRCModels = LRCModels;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.LRCModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XRLRCCell *cell = [XRLRCCell cellWithTableView:tableView];
    cell.LRCModel = self.LRCModels[indexPath.row];
    
    // 更新进度
    if (indexPath.row == self.scrollRow) {
        cell.progress = self.progress;
        cell.highLight = YES;
    } else {
        cell.progress = 0;
        cell.highLight = NO;

    }
    
    return cell;
}

/**
 *  重写歌词进度的set方法, 在此方法中, 设置歌词进度
 */
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    // 获取当前的行号
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.scrollRow inSection:0];
    
    // 取出对应的cell
    XRLRCCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // 设置进度
    cell.progress = progress;
}

- (void)setScrollRow:(NSInteger)scrollRow
{
    // 通过这个判断, 过滤同一行的频繁刷新
    if (_scrollRow == scrollRow) {
        return;
    }
    _scrollRow = scrollRow;
    
    // 获取需要滚动的IndexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_scrollRow inSection:0];
    
    // 刷新表格
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationFade];
    
    // 滚动到对应行
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
