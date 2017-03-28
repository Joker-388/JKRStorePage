//
//  JKRMainViewController.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRMainViewController.h"
#import "JKRCanCloseScrollView.h"
#import "JKRTitleView.h"
#import "JKRProjectViewController.h"
#import "JKRDetailViewController.h"
#import "JKRCommentViewController.h"

@interface JKRMainViewController ()<UIScrollViewDelegate>

/// 根scrollView
@property (nonatomic, strong) JKRCanCloseScrollView *scrollView;
/// 状态栏顶部选项数组
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
/// 状态栏顶部视图
@property (nonatomic, strong) JKRTitleView *titleView;
/// 产品信息页
@property (nonatomic, strong) JKRProjectViewController *projectViewController;
/// 产品图文详情页
@property (nonatomic, strong) JKRDetailViewController *detailViewController;
/// 产品评论页
@property (nonatomic, strong) JKRCommentViewController *commentViewController;

@end

@implementation JKRMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
    [self _setTitleView];
    [self _addChildViewController];
}

- (void)_setTitleView {
    self.navigationItem.titleView = self.titleView;
    @weakify(self);
    self.titleView.block = ^(int index) {
        @strongify(self);
        [self.scrollView scrollRectToVisible:CGRectMake(index * self.view.width, 0.0, self.view.width, self.view.height) animated:YES];
    };
}

- (void)_addChildViewController {
    [self addChildViewController:self.projectViewController];
    [self addChildViewController:self.detailViewController];
    [self addChildViewController:self.commentViewController];
    @weakify(self);
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        obj.view.frame = CGRectMake(idx * self.scrollView.width, 0, self.scrollView.width, self.scrollView.height);
        [self.scrollView addSubview:obj.view];
    }];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[JKRCanCloseScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _scrollView.contentSize = CGSizeMake(self.view.width * self.titleArray.count, self.view.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"商品", @"详情", @"评价"];
    }
    return _titleArray;
}

- (JKRTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[JKRTitleView alloc] init];
        _titleView.titleArray = self.titleArray;
    }
    return _titleView;
}

- (JKRProjectViewController *)projectViewController {
    if (!_projectViewController) {
        _projectViewController = [[JKRProjectViewController alloc] init];
    }
    return _projectViewController;
}

- (JKRDetailViewController *)detailViewController {
    if (!_detailViewController) {
        _detailViewController = [[JKRDetailViewController alloc] init];
    }
    return _detailViewController;
}

- (JKRCommentViewController *)commentViewController {
    if (!_commentViewController) {
        _commentViewController = [[JKRCommentViewController alloc] init];
    }
    return _commentViewController;
}

- (void)dealloc {
    
}

@end
