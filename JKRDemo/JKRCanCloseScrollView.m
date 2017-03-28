//
//  JKRCanCloseScrollView.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRCanCloseScrollView.h"

@implementation JKRCanCloseScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.panGestureRecognizer.delegate = self;
    self.isOpen = YES;
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (_isOpen) {
        return YES;
    }
    return NO;
}

@end
