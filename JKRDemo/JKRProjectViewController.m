//
//  JKRProjectViewController.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRProjectViewController.h"
#import "JKRProjectTopView.h"
#import "JKRProjectBottomView.h"
#import "JKRTitleView.h"
#import "JKRCanCloseScrollView.h"

@interface JKRProjectViewController ()

/// 所有视图的容器根视图
@property (nonatomic, strong) UIView *contentView;
/// 容器根视图下顶部产品概要视图
@property (nonatomic, strong) JKRProjectTopView *topView;
/// 容器根树图下底部产品详情视图
@property (nonatomic, strong) JKRProjectBottomView *bottomView;

@end

@implementation JKRProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.bottomView];
    @weakify(self);
    // 下拉显示详情
    self.topView.block = ^ {
        @strongify(self);
        [UIView animateWithDuration:0.4 animations:^{
            self.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -kScreenHeight);
            JKRTitleView *titleView = (JKRTitleView *)self.parentViewController.navigationItem.titleView;
            titleView.contentOffset = CGPointMake(0.0, titleView.height);
            JKRCanCloseScrollView *scrollView = [self.parentViewController valueForKeyPath:@"scrollView"];
            scrollView.isOpen = NO;
        }];
    };
    // 上拉显示产品
    self.bottomView.block = ^ {
        @strongify(self);
        [UIView animateWithDuration:0.4 animations:^{
            self.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            JKRTitleView *titleView = (JKRTitleView *)self.parentViewController.navigationItem.titleView;
            titleView.contentOffset = CGPointMake(0.0, 0.0);
            JKRCanCloseScrollView *scrollView = [self.parentViewController valueForKeyPath:@"scrollView"];
            scrollView.isOpen = YES;
        }];
    };
}

#pragma mark - lazy load
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kScreenHeight * 2)];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (JKRProjectTopView *)topView {
    if (!_topView) {
        _topView = [[JKRProjectTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _topView;
}

- (JKRProjectDetailView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[JKRProjectBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    }
    return _bottomView;
}

@end
