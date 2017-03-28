//
//  JKRProjectBottomView.h
//  JKRDemo
//
//  Created by tronsis_ios on 17/3/27.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRProjectDetailView.h"

typedef void(^moveUpBlock)();

@interface JKRProjectBottomView : JKRProjectDetailView<UIScrollViewDelegate>

@property (nonatomic, strong) moveUpBlock block;

@end
