//
//  JKRProjectTopView.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRProjectTopView.h"
#import "JKRProjectImagesView.h"
#import "JKRProjectOtherView.h"

@interface JKRProjectTopView ()<UIScrollViewDelegate>

/// 图片数据
@property (nonatomic, strong) NSArray *imagesArray;
/// 顶部图片滚动视图
@property (nonatomic, strong) JKRProjectImagesView *imagesView;
/// 底部其它内容视图
@property (nonatomic, strong) JKRProjectOtherView *otherView;
/// 底部提示文字视图
@property (nonatomic, strong) UILabel *displayLabel;

@end

@implementation JKRProjectTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.contentInset = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0);
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor lightGrayColor];
    self.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 1.2);
    [self addSubview:self.imagesView];
    [self addSubview:self.otherView];
    [self addSubview:self.displayLabel];
    self.delegate = self;
    self.imagesView.imagesArray = self.imagesArray;
    return self;
}

#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset = scrollView.contentOffset.y;
    [_imagesView bringSubviewToFront:self.otherView];
    CGRect imagesViewFrame = self.imagesView.frame;
    imagesViewFrame.origin.y = (yOffset + 64) / 2;
    self.imagesView.frame = imagesViewFrame;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        CGFloat yOffset = scrollView.contentOffset.y;
        CGFloat moveUpOffset = (self.contentSize.height - kScreenHeight) + 80.0;
        if (yOffset > moveUpOffset) {
            self.block();
        }
    }
}

#pragma mark - lazy load
- (JKRProjectImagesView *)imagesView {
    if (!_imagesView) {
        _imagesView = [[JKRProjectImagesView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    }
    return _imagesView;
}

- (JKRProjectOtherView *)otherView {
    if (!_otherView) {
        _otherView = [[JKRProjectOtherView alloc] initWithFrame:CGRectMake(0, self.imagesView.height, kScreenWidth, kScreenHeight * 1.2 - self.imagesView.height)];
        _otherView.backgroundColor = [UIColor greenColor];
    }
    return _otherView;
}

- (UILabel *)displayLabel {
    if (!_displayLabel) {
        _displayLabel = [[UILabel alloc] init];
        _displayLabel.text = @"上拉显示商品详情";
        _displayLabel.textAlignment = NSTextAlignmentCenter;
        _displayLabel.frame = CGRectMake(0, CGRectGetMaxY(self.otherView.frame), self.width, 40);
    }
    return _displayLabel;
}

- (NSArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = @[@"0", @"1", @"2", @"3", @"4", @"5"];
    }
    return _imagesArray;
}

@end
