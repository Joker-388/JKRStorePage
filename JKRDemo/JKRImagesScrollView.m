//
//  JKRImagesScrollView.m
//  JKRDemo
//
//  Created by ; on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRImagesScrollView.h"

@implementation JKRImagesScrollView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 修复轻滑崩溃的bug
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat pointX = [pan translationInView:self].x;
        BOOL result = [super gestureRecognizerShouldBegin:gestureRecognizer];
        if (!result && pointX < 0) {
            return NO;
        }
    }
    return YES;
}

@end
