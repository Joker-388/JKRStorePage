//
//  JKRTitleView.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRTitleView.h"

@interface JKRTitleView ()

@end

@implementation JKRTitleView

static const CGFloat btnWidht = 40.0;
static const CGFloat btnSpace = 20.0;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.scrollEnabled = NO;
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    self.frame = CGRectMake(0.0, 0.0, (btnWidht + btnSpace) * titleArray.count - btnSpace, 44);
    for (unsigned int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * (btnWidht + btnSpace), 0.0, btnWidht, 44.0);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.accessibilityValue = [NSString stringWithFormat:@"%d", i];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [self addSubview:button];
    }
    UIView *nextTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, (btnWidht + btnSpace) * titleArray.count - btnSpace, 44)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:nextTitleView.bounds];
    titleLabel.text = @"图文详情";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextTitleView addSubview:titleLabel];
    [self addSubview:nextTitleView];
}

- (void)buttonClick:(UIButton *)sender {
    self.block([sender.accessibilityValue intValue]);
}

@end
