//
//  JKRProjectTopView.h
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^moveDownBlock)();

@interface JKRProjectTopView : UIScrollView

@property (nonatomic, strong) moveDownBlock block;

@end
