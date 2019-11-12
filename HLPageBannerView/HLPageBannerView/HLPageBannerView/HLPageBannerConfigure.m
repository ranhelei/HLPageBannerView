//
//  HLPageBannerConfigure.m
//  banner
//
//  Created by 冉合磊 on 2019/10/29.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import "HLPageBannerConfigure.h"

@implementation HLPageBannerConfigure
- (instancetype)init {
    if (self = [super init]) {
        //属性默认值
        _scrollBounces = NO;
        _imgMaxHeight = MAXFLOAT;
        _imgMinHeight = 0;
        _dotWith = 4.5;
        _dotMagin = 4.5;
        _dotTintColor = [[UIColor whiteColor]colorWithAlphaComponent:0.4];
        _dotSelectColor = [UIColor whiteColor];
        _imgShadowMask = YES;
        _imgShadowColors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.0].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.4].CGColor];
    }
    return self;
}

@end
