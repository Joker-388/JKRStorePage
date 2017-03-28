//
//  JKRProjectDetailView.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRProjectDetailView.h"

@interface JKRProjectDetailView ()

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIView *detailView;

@end

@implementation JKRProjectDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.detailView];
    return self;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _contentView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 1.2);
        _contentView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.delegate = self;
    }
    return _contentView;
}

- (UIView *)detailView {
    if (!_detailView) {
        _detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 1.2)];
        _detailView.backgroundColor = [UIColor lightGrayColor];
    }
    return _detailView;
}

@end
