//
//  AppDelegate+JKRRootViewController.m
//  ZHYQ
//
//  Created by Joker on 14/3/15.
//  Copyright © 2014年 Joker. All rights reserved.
//

#import "AppDelegate+JKRRootViewController.h"
#import "JKRNavigationViewController.h"
#import "JKRHomeViewController.h"

@implementation AppDelegate (JKRRootViewController)

- (void)jkr_configRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JKRNavigationViewController *navigationController = [[JKRNavigationViewController alloc] initWithRootViewController:[[JKRHomeViewController alloc] init]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

@end
