//
//  HLPageBannerConfigure.h
//  banner
//
//  Created by 冉合磊 on 2019/10/29.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLPageBannerConfigure : NSObject

//scrollview相关
@property (nonatomic, assign) BOOL scrollBounces;//是否开启边界反弹 默认NO

//图片相关
@property (nonatomic, assign) CGFloat imgMinHeight;//图片最小高度 默认0
@property (nonatomic, assign) CGFloat imgMaxHeight;//图片最大高度 默认max
@property (nonatomic, assign) BOOL imgShadowMask;//图片上是否有阴影遮罩 默认YES
@property (nonatomic, copy) NSArray *imgShadowColors;//阴影遮罩颜色渐变值

//pageControl相关
@property (nonatomic, assign) CGFloat dotWith;//圆点宽高 默认4.5
@property (nonatomic, assign) CGFloat dotMagin;//圆点间距 默认4.5
@property (nonatomic, strong) UIColor *dotTintColor;//圆点默认颜色
@property (nonatomic, strong) UIColor *dotSelectColor;//圆点选中颜色
@end

NS_ASSUME_NONNULL_END
