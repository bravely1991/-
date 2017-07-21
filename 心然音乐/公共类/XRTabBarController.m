//
//  XRTabBarViewController.m
//  心然音乐
//
//  Created by brave on 2017/7/21.
//  Copyright © 2017年 心然. All rights reserved.
//

#import "XRTabBarController.h"
#import "XRNavigationController.h"

#import "XRDisCoverViewController.h"
#import "XRMyViewController.h"
#import "XRFriendViewController.h"
#import "XRAccountViewController.h"

@interface XRTabBarController ()

@end

@implementation XRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadChildViewControllers];
    [self setupItemTextAttrs];
    
    [self.tabBar setBarStyle:UIBarStyleBlack];
//    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadChildViewControllers {
    [self addChildViewController:[[XRNavigationController alloc] initWithRootViewController:[XRDisCoverViewController new]] title:@"发现音乐" image:@"cm2_btm_icn_discovery" selectedImage:@"cm2_btm_icn_discovery_prs"];
    [self addChildViewController:[[XRNavigationController alloc] initWithRootViewController:[XRMyViewController new]] title:@"我的音乐" image:@"cm2_btm_icn_music" selectedImage:@"cm2_btm_icn_music_prs"];
    [self addChildViewController:[[XRNavigationController alloc] initWithRootViewController:[XRFriendViewController new]] title:@"朋友" image:@"cm2_btm_icn_friend" selectedImage:@"cm2_btm_icn_friend_prs"];
    [self addChildViewController:[[XRNavigationController alloc] initWithRootViewController:[XRAccountViewController new]] title:@"账号" image:@"cm2_btm_icn_account" selectedImage:@"cm2_btm_icn_account_prs"];
    
}

- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:vc];
    
}

- (void)setupItemTextAttrs {
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
