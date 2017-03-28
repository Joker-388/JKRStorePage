//
//  JKRProjectBottomView.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRProjectBottomView.h"

@interface JKRProjectBottomView ()

@property (nonatomic, strong) UILabel *displayLabel;

@end

@implementation JKRProjectBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self insertSubview:self.displayLabel atIndex:0];
    return self;
}

#pragma mark - scroll view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < -110) {
        self.displayLabel.text = @"释放回商品主页";
    } else {
        self.displayLabel.text = @"下拉回到商品主页";
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < -110) {
        self.block();
    }
}

#pragma mark - lazy load
- (UILabel *)displayLabel {
    if (!_displayLabel) {
        _displayLabel = [[UILabel alloc] init];
        _displayLabel.frame = CGRectMake(0, 64, kScreenWidth, 44);
        _displayLabel.textAlignment = NSTextAlignmentCenter;
        _displayLabel.text = @"下拉回到商品主页";
    }
    return _displayLabel;
}

@end
