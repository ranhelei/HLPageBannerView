//
//  HLbannerHeader.h
//  banner
//
//  Created by 冉合磊 on 2019/10/25.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLPageBannerModel.h"
#import "HLBannerImageView.h"
#import "HLPageBannerConfigure.h"
NS_ASSUME_NONNULL_BEGIN
@protocol HLbannerHeaderDelegate <NSObject>
//图片滚动回调
- (void)HLScrollViewDidScroll:(UIScrollView *)scrollView;
@optional
//点击图片回调
- (void)HLBannerImgTap:(HLBannerImageView *)imgView;
- (void)HLBannerImgIndex:(NSInteger)currentIndex;
@end

@interface HLbannerHeader : UIView
@property (nonatomic, weak) id<HLbannerHeaderDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame configure:(HLPageBannerConfigure *)configure;
//设置数据和刷新数据
- (void)reloadWithLists:(NSArray<HLPageBannerModel *> *)listArray;
@end

NS_ASSUME_NONNULL_END
