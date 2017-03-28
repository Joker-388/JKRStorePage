//
//  JKRHomeViewController.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRHomeViewController.h"
#import "JKRMainViewController.h"

@interface JKRHomeViewController ()

@end

@implementation JKRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Home view";
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    [button setTitle:@"Show main page" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(goHomePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    [button addConstraint:width];
    [button addConstraint:height];
    [self.view addConstraint:centerX];
    [self.view addConstraint:centerY];
}

- (void)goHomePage {
    [self.navigationController pushViewController:[[JKRMainViewController alloc] init] animated:YES];
}

@end
