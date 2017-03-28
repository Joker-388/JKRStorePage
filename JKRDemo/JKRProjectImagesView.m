//
//  JKRProjectImagesView.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRProjectImagesView.h"
#import "JKRImagesScrollView.h"
#import "JKRPageView.h"

@interface JKRProjectImagesView ()<UIScrollViewDelegate>

/// 图片scrollView
@property (nonatomic, strong) JKRImagesScrollView *imagesScrollView;
/// 当前页码
@property (nonatomic, assign) NSInteger currentIndex;
/// 页码视图
@property (nonatomic, strong) JKRPageView *pageView;

@end

@implementation JKRProjectImagesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor orangeColor];
    return self;
}

- (void)setImagesArray:(NSArray *)imagesArray {
    _imagesArray = imagesArray;
    _currentIndex = 0;
    [self addSubview:self.imagesScrollView];
    _imagesScrollView.contentSize = CGSizeMake(self.width * imagesArray.count, self.height);
    for (unsigned int i = 0; i < imagesArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * self.width, 0, self.width, self.height);
        imageView.image = [UIImage imageNamed:imagesArray[i]];
        [self.imagesScrollView addSubview:imageView];
        // 一定要加这句，否则scrollView手势关闭后，touch事件不能传递到上一级scrollView
        imageView.userInteractionEnabled = YES;
    }
    [self addSubview:self.pageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat xOffset = scrollView.contentOffset.x;
    // 设置偏移
    int index = xOffset / self.width;
    UIImageView *imageView = scrollView.subviews[index];
    CGRect frame = imageView.frame;
    frame.origin.x = index * self.width + xOffset / 2 - (index * self.width) / 2;
    imageView.frame = frame;
    // 设置页码动画
    [self pageNumberViewAnimation:xOffset];
    // scrollView手势开关
    BOOL isLeft = [scrollView.panGestureRecognizer translationInView:self].x < 0 ? YES : NO;
    if (index == _imagesArray.count - 1 && isLeft) {
        _imagesScrollView.isOpen = NO;
    } else {
        _imagesScrollView.isOpen = YES;
    }
}

- (void)pageNumberViewAnimation:(CGFloat)xOffset {
    // 越过一半就算下一页的页码
    int page = (int)(xOffset / self.imagesScrollView.width + 0.5);
    // 当前页码
    int index = xOffset / self.imagesScrollView.width;
    self.currentIndex = page;
    CGFloat tmpOffset;
    if (page > index) {
        // 越过一半的动画参数
        tmpOffset = xOffset - page * self.imagesScrollView.width;
    } else {
        // 没约过一半的动画参数
        tmpOffset = xOffset - index * self.imagesScrollView.width;
    }
    self.pageView.layer.transform = CATransform3DMakeRotation(tmpOffset * M_PI / self.width, 0, 1, 0);
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    self.pageView.text = [NSString stringWithFormat:@"%zd/%zd", _currentIndex + 1, _imagesArray.count];
}

#pragma mark - lazy load
- (JKRCanCloseScrollView *)imagesScrollView {
    if (!_imagesScrollView) {
        _imagesScrollView = [[JKRImagesScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _imagesScrollView.contentSize = CGSizeMake(self.width * 3, self.height);
        _imagesScrollView.pagingEnabled = YES;
        _imagesScrollView.bounces = NO;
        _imagesScrollView.showsHorizontalScrollIndicator = NO;
        _imagesScrollView.showsVerticalScrollIndicator = NO;
        _imagesScrollView.delegate = self;
    }
    return _imagesScrollView;
}

- (JKRPageView *)pageView {
    if (!_pageView) {
        _pageView = [[JKRPageView alloc] initWithFrame:CGRectMake(self.width - 50, self.height - 40, 30, 30)];
        _pageView.textColor = [UIColor whiteColor];
        _pageView.text = [NSString stringWithFormat:@"%zd/%zd", _currentIndex + 1, _imagesArray.count];
        _pageView.layer.zPosition = 16.f;
    }
    return _pageView;
}

@end
