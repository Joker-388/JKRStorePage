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
/// 左侧imageView
@property (nonatomic, strong) UIImageView *leftImageView;
/// 中间scrollView
@property (nonatomic, strong) UIImageView *centerImageView;
/// 右侧scrollView
@property (nonatomic, strong) UIImageView *rightImageView;
/// 当前页码
@property (nonatomic, assign) NSInteger currentIndex;
/// 上一次的offset
@property (nonatomic, assign) CGFloat lastXoffset;
/// 页码
@property (nonatomic, strong) JKRPageView *pageView;

@end

@implementation JKRProjectImagesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor orangeColor];
    return self;
}

#pragma mark - set value and ui
- (void)setImagesArray:(NSArray *)imagesArray {
    _imagesArray = imagesArray;
    _currentIndex = 0;
    [self addSubview:self.imagesScrollView];
    [self.imagesScrollView addSubview:self.leftImageView];
    [self.imagesScrollView addSubview:self.centerImageView];
    [self.imagesScrollView addSubview:self.rightImageView];
    [self addSubview:self.pageView];
}

#pragma mark - scroll view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat xOffset = scrollView.contentOffset.x;
    if (xOffset < self.width) {
        // 当从左侧往中间滚，或者从中间往左侧滚，调节左侧图片实现重叠效果
        [_imagesScrollView bringSubviewToFront:_centerImageView];
        [self bringImageView:_leftImageView fromXStart:0 byOffset:xOffset];
    } else if (xOffset > self.width) {
        // 当从中间往右侧滚，或者从右侧往中间滚，调节中间图片实现重叠效果
        [_imagesScrollView bringSubviewToFront:_rightImageView];
        [_imagesScrollView sendSubviewToBack:_centerImageView];
        [_imagesScrollView sendSubviewToBack:_leftImageView];
        [self bringImageView:_centerImageView fromXStart:self.width byOffset:(xOffset - self.width)];
    }
    [self pageNumberViewAnimation:xOffset];
    [self resetCurrentIndex:xOffset];
    _lastXoffset = xOffset;
    BOOL isLeft = [scrollView.panGestureRecognizer translationInView:self].x < 0 ? YES : NO;
    if (_currentIndex == _imagesArray.count - 1 && isLeft) {
        _imagesScrollView.isOpen = NO;
    } else {
        _imagesScrollView.isOpen = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_currentIndex < _imagesArray.count - 1 && _currentIndex > 0) {
        // 如果当前的页码数小于图片数量－1，且大于0的时刻，重置scrollView。
        [self resetImages];
    }
}

#pragma mark - set images
- (void)resetCurrentIndex:(CGFloat)xOffset {
    if (xOffset > self.width / 2 && _lastXoffset <= self.width / 2) {
        // 当水平方向的滚动距离大于图片尺寸的一半，且上一次水平方向滚动距离小于等于图片尺寸的一半。
        // 即滚动到图片一半宽度以上的时刻，currentIndex自增1
        self.currentIndex++;
        NSLog(@"_currentIndex++: %zd", _currentIndex);
    } else if (xOffset < self.width / 2 && _lastXoffset >= self.width / 2) {
        // 当水平方向的滚动距离小于图片尺寸的一半，且上一次水平方向滚动距离大于等于图片尺寸的一半。
        // 即滚动回图片一半宽度以内的时刻，currentIndex自减1
        self.currentIndex--;
        NSLog(@"_currentIndex--: %zd", _currentIndex);
    } else if (xOffset > 3 * self.width / 2 && _lastXoffset <= 3 * self.width / 2) {
        // 当水平方向的滚动距离大于图片尺寸的1.5倍距离，且上一次水平方向滚动距离小于等于图片尺寸的1.5倍距离。
        // 即滚动到最左侧图片的一半的时刻，currentIndex自增1
        self.currentIndex++;
        NSLog(@"_currentIndex++: %zd", _currentIndex);
    } else if (xOffset < 3 * self.width / 2 && _lastXoffset >= 3 * self.width / 2) {
        // 当水平方向的滚动距离小于图片尺寸的1.5倍距离，且上一次水平方向滚动距离大于等于图片尺寸的1.5倍距离。
        // 即滚动回最左侧图片的一半的时刻，currentIndex自减1
        self.currentIndex--;
        NSLog(@"_currentIndex--: %zd", _currentIndex);
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    self.pageView.text = [NSString stringWithFormat:@"%zd/%zd", _currentIndex + 1, _imagesArray.count];
}

- (void)resetImages {
    CGFloat ratio = 0.5;
    _leftImageView.image = [UIImage imageNamed:_imagesArray[_currentIndex - 1]];
    _leftImageView.frame = CGRectMake((1 - ratio) * self.width, 0.0, self.width, self.height);
    
    _centerImageView.image = [UIImage imageNamed:_imagesArray[_currentIndex]];
    _centerImageView.frame = CGRectMake(self.width, 0.0, self.width, self.height);
    
    _rightImageView.image = [UIImage imageNamed:_imagesArray[_currentIndex + 1]];
    _rightImageView.frame = CGRectMake(self.width * 2, 0, self.width, self.height);
    
    _lastXoffset = self.width;
    [_imagesScrollView scrollRectToVisible:CGRectMake(self.width, 0.0, self.width, self.height) animated:NO];
}

#pragma mark - index animation
- (void)pageNumberViewAnimation:(CGFloat)xOffset {
    CGFloat tmpOffset = xOffset;
    if (xOffset <= self.width / 2) {
        
    } else if (xOffset > self.width / 2 && xOffset <= self.width) {
        tmpOffset = xOffset - self.width;
    } else if (xOffset > self.width && xOffset <= 3 * self.width / 2) {
        tmpOffset = xOffset - self.width;
    } else if (xOffset > 3 * self.width / 2 && xOffset <= 2 * self.width) {
        tmpOffset = xOffset - 2 * self.width;
    }
    self.pageView.layer.transform = CATransform3DMakeRotation(tmpOffset * M_PI / self.width, 0, 1, 0);
}

#pragma mark - overlap
- (void)bringImageView:(UIImageView *)imageView fromXStart:(CGFloat)xStart byOffset:(CGFloat)xOffset {
    CGRect frame = imageView.frame;
    frame.origin.x = xOffset/2 + xStart;
    imageView.frame = frame;
}

#pragma mark - lazy load
- (JKRCanCloseScrollView *)imagesScrollView {
    if (!_imagesScrollView) {
        _imagesScrollView = [[JKRImagesScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _imagesScrollView.contentSize = CGSizeMake(self.width * 3, self.height);
        _imagesScrollView.pagingEnabled = YES;
        _imagesScrollView.bounces = NO;
        _imagesScrollView.showsHorizontalScrollIndicator = NO;
        _imagesScrollView.delegate = self;
    }
    return _imagesScrollView;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imagesArray[_currentIndex]]];
        _leftImageView.frame = CGRectMake(0, 0, self.width, self.height);
        _leftImageView.userInteractionEnabled = YES;
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imagesArray[_currentIndex+1]]];
        _centerImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
        _centerImageView.userInteractionEnabled = YES;
        _centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imagesArray[_currentIndex+2]]];
        _rightImageView.frame = CGRectMake(self.width*2, 0, self.width, self.height);
        _rightImageView.userInteractionEnabled = YES;
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightImageView;
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
