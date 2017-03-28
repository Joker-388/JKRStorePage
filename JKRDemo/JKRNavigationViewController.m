//
//  JKRNavigationViewController.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRNavigationViewController.h"

@interface JKRNavigationViewController ()

@end

@implementation JKRNavigationViewController

+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[JKRNavigationViewController class]]];
    [navigationBar setTintColor:[UIColor darkGrayColor]];
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[JKRNavigationViewController class]]];
    [barButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

@end
