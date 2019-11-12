//
//  HLPageBannerView.h
//  banner
//
//  Created by 冉合磊 on 2019/10/25.
//  Copyright © 2019 冉合磊. All rights reserved.
//此view为主要的结构，包含了头部的滑动控件和底下的tableView

#import <UIKit/UIKit.h>
#import "HLPageBannerModel.h"
#import "HLPageBannerConfigure.h"
#import "HLbannerHeader.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HLPageBannerViewDelegate <NSObject>
@required
//传入一个tableView
- (UITableView *)HLTableViewForPageBanner;

@optional
//banner图片点击
- (void)HLBannerImageTapAction:(NSInteger)index;
@end

@interface HLPageBannerView : UIView
@property (nonatomic, strong) HLbannerHeader *headerView;
//图片model数组
@property (nonatomic, copy) NSArray<HLPageBannerModel *> *listArray;
- (instancetype)initWithFrame:(CGRect)frame delegate:(id <HLPageBannerViewDelegate>)delegate configure:(HLPageBannerConfigure *)configure;
@end

NS_ASSUME_NONNULL_END
