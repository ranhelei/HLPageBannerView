//
//  HLBannerPageControl.m
//  banner
//
//  Created by 冉合磊 on 2019/10/29.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import "HLBannerPageControl.h"

@interface HLBannerPageControl ()
@property (nonatomic, strong) HLPageBannerConfigure *configure;
@end
@implementation HLBannerPageControl
- (instancetype)initWithConfigure:(HLPageBannerConfigure *)configure {
    self = [super init];
    if (self) {
        _configure = configure;
        self.hidesForSinglePage = YES;
        self.pageIndicatorTintColor = self.configure.dotTintColor;
        self.currentPageIndicatorTintColor = self.configure.dotSelectColor;
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (self.currentPage == currentPage) {
        return;
    }
    [super setCurrentPage:currentPage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //计算圆点间距
    CGFloat marginX = self.configure.dotWith + self.configure.dotMagin;
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        dot.layer.cornerRadius = self.configure.dotWith * 0.5;
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, self.configure.dotWith, self.configure.dotWith)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, self.configure.dotWith, self.configure.dotWith)];
        }
    }
}

@end
