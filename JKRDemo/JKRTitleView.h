//
//  JKRTitleView.h
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^titleButtonBlock) (int index);

@interface JKRTitleView : UIScrollView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) titleButtonBlock block;

@end
