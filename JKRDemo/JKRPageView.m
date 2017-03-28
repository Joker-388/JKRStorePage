//
//  JKRPageView.m
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/28.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRPageView.h"

@interface JKRPageView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation JKRPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.image = [UIImage imageNamed:@"product_page"];
    self.backgroundColor = JKRColor(217, 217, 217, 0.6);
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 1)];
    self.textLabel.attributedText = attributedString;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}

@end
