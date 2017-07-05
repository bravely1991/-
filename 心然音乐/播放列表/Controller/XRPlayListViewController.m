//
//  XRViewController.m
//  心然音乐
//
//  Created by brave on 2017/6/28.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRPlayListViewController.h"
#import "XRPlayListCell.h"
#import "XRPlayListToolBar.h"
#import "XRPlayViewController.h"


@interface XRPlayListViewController ()<UITableViewDataSource,UITableViewDelegate,XRPlaySingtonDelegate>

@property (nonatomic, strong) UITableView *playListTableView;
@property (nonatomic, strong) XRPlayListToolBar *toolBar;
@property (nonatomic, strong) NSArray *playListModels;

@end

@implementation XRPlayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"播放列表";
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
//    self.navigationController.navigationBar.hidden = YES;
    
    [self loadSubViews];
    
    XRPlayListModel *listModel = [[XRPlayListModel alloc] init];
    listModel.name = @"泡沫";
    listModel.filename = @"paomo";
    listModel.album = @"邓紫棋";
    
    XRPlayListModel *listModel2 = [[XRPlayListModel alloc] init];
    listModel2.name = @"匆匆那年";
    listModel2.filename = @"匆匆那年";
    listModel2.album = @"王菲";
    
    XRPlayListModel *listModel3 = [[XRPlayListModel alloc] init];
    listModel3.name = @"但愿人长久";
    listModel3.filename = @"但愿人长久";
    listModel3.album = @"王菲";
    
    XRPlayListModel *listModel4 = [[XRPlayListModel alloc] init];
    listModel4.name = @"红豆";
    listModel4.filename = @"红豆";
    listModel4.album = @"王菲";
    
    self.playListModels = @[listModel,listModel2,listModel3,listModel4];
    
    [XRPlaySington sharedInstance].playList = @[listModel,listModel2,listModel3,listModel4];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.toolBar updatePlayState:[XRPlaySington sharedInstance].player.isPlaying];
    [XRPlaySington sharedInstance].updateDdelegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubViews {
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image = [UIImage imageNamed:@"image_playlist_background"];
    [self.view addSubview:backgroundView];
    
    self.playListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, XRWidth, XRHeight-64-49) style:UITableViewStyleGrouped];
    self.playListTableView.rowHeight = 50.f;
    self.playListTableView.dataSource = self;
    self.playListTableView.delegate   = self;
    self.playListTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.playListTableView];
    
    self.toolBar = [[XRPlayListToolBar alloc] initWithFrame:CGRectMake(0, XRHeight-49, XRWidth, 49)];
    
//    self.toolBar.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.toolBar];
    
}

- (void)updateWithRow:(NSInteger)row LRCModel:(XRLRCModel *)LRCModel {
    self.toolBar.LRCText = LRCModel.lrcText;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playListModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XRPlayListCell *cell = [XRPlayListCell cellWithTableView:tableView];
    cell.listModel = self.playListModels[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XRPlayViewController *playViewController = [[XRPlayViewController alloc] init];
    [XRPlaySington sharedInstance].currentPlayIndex = indexPath.row;
    
    [self.navigationController pushViewController:playViewController animated:YES];
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
