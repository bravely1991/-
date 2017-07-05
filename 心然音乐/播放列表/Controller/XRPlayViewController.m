//
//  XRPlayViewController.m
//  心然音乐
//
//  Created by brave on 2017/6/28.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlayViewController.h"
#import "XRPlayControlToolBar.h"
#import "XRPlayMainView.h"
#import "XRPlayLyricsView.h"
#import "XRLRCAnalysiser.h"

@interface XRPlayViewController ()<XRPlayControlToolBarDelegate,XRPlaySingtonDelegate>

@property (nonatomic, strong) XRPlayControlToolBar *playControlToolBar;
@property (nonatomic, strong) XRPlayMainView *playMainView;
@property (nonatomic, strong) XRPlayLyricsView *playLyricsView;


///** 负责更新歌词的定时器 */
//@property (nonatomic, strong) CADisplayLink *LrcLink;
@property (nonatomic, strong) NSArray *LRCModels;

@end

@implementation XRPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image = [UIImage imageNamed:@"image_playlist_background"];
    [self.view addSubview:backgroundView];
    
    self.navigationItem.title = [XRPlaySington sharedInstance].playModel.name;
    
    [self layoutSubviews];
    
    self.LRCModels =  [XRLRCAnalysiser getLrcModelsWithFileName:[XRPlaySington sharedInstance].playModel.filename];
//    self.LrcLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrc)];
//    [self.LrcLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    [self.LrcLink setPaused:![XRPlaySington sharedInstance].player.isPlaying];
    self.playLyricsView.LRCModels = self.LRCModels;
    
    
    [self.playControlToolBar setTotalTime:[XRPlaySington sharedInstance].player.duration];
    [self.playControlToolBar updatePlayState:[XRPlaySington sharedInstance].player.isPlaying];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [XRPlaySington sharedInstance].updateDdelegate = self;

}

- (void)updateWithRow:(NSInteger)row LRCModel:(XRLRCModel *)LRCModel {
    self.playLyricsView.scrollRow = row;

    
    CGFloat progress = ([XRPlaySington sharedInstance].player.currentTime - LRCModel.beginTime) / (LRCModel.endTime - LRCModel.beginTime);
    // 传值给歌词控制器, 让歌词控制器的歌词负责进度展示
    self.playLyricsView.progress = progress;
    self.playMainView.LRCText = LRCModel.lrcText;
    self.playModel.costTime = [XRPlaySington sharedInstance].player.currentTime;
    
    [self.playControlToolBar updatePlayProcessView:[XRPlaySington sharedInstance].player.currentTime endTime:[XRPlaySington sharedInstance].player.duration];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutSubviews {
    
    self.playMainView = [[XRPlayMainView alloc] initWithFrame:CGRectMake(0, 0, XRWidth, XRHeight-103)];
    self.playLyricsView = [[XRPlayLyricsView alloc] initWithFrame:CGRectMake(XRWidth, 0, XRWidth, XRHeight-103)];
    
    
    [self.view addSubview:self.playMainView];
    [self.view addSubview:self.playLyricsView];
    
    
    self.playControlToolBar = [[XRPlayControlToolBar alloc] initWithFrame:CGRectMake(0, XRHeight-103, XRWidth, 103)];
    self.playControlToolBar.XRDelegate = self;
    [self.view addSubview:self.playControlToolBar];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
}

#pragma mark - XRPlayControlToolBarDelegate
- (void)playPauseBtnEvent:(BOOL)isPlaying {
    if (isPlaying) {
        [self.playMainView resumeRotation];
    } else {
        [self.playMainView pauseRotation];
    }
}

- (void)priorBtnEvent {
    
}

- (void)nextBtnEvent {
    
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    // 获取x轴偏移量
    CGFloat offsetX = [pan translationInView:self.view].x;
    // 修改slideView的frame
    self.playLyricsView.frame = [self frameWithOffsetX:offsetX];
    // 复位
    [pan setTranslation:CGPointZero inView:self.view];
    
    // 当手指抬起的时候,定位
    if (pan.state == UIGestureRecognizerStateEnded) {
        // 左滑
        if (self.playLyricsView.frame.origin.x < XRWidth*0.5) {
            offsetX = -self.playLyricsView.frame.origin.x;
            [UIView animateWithDuration:0.1f animations:^{
                // 计算最新frame
                self.playLyricsView.frame = [self frameWithOffsetX:offsetX];
            }];
        }else{
            offsetX = XRWidth - self.playLyricsView.frame.origin.x;
            [UIView animateWithDuration:0.1f animations:^{
                // 计算最新frame
                self.playLyricsView.frame = [self frameWithOffsetX:offsetX];
            }];
        }
    }
    
    CGFloat alpha = 1.3 - self.playLyricsView.frame.origin.x/XRWidth;

    self.playLyricsView.alpha = alpha > 1 ? 1 : alpha;
    
}

- (CGRect)frameWithOffsetX:(CGFloat)offsetX {
    // 获取上一次mainView的frame
    CGRect frame = self.playLyricsView.frame;
    frame.origin.x += offsetX;
    
    //最大左滑距离不能超过自己的宽度
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
    }
    //最大右滑距离不能超过自己左边界
    if (frame.origin.x > XRWidth) {
        frame.origin.x = XRWidth;
    }
    
    return frame;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
