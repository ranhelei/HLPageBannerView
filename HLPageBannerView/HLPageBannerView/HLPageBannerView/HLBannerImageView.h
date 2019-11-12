//
//  HLBannerImageView.h
//  banner
//
//  Created by 冉合磊 on 2019/10/29.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLPageBannerModel.h"
#import "HLPageBannerConfigure.h"
NS_ASSUME_NONNULL_BEGIN

@interface HLBannerImageView : UIImageView
@property (nonatomic, strong) HLPageBannerModel *model;
@property (nonatomic, assign) NSInteger index;//图片索引

- (instancetype)initWithFrame:(CGRect)frame configure:(HLPageBannerConfigure *)configure;
@end

NS_ASSUME_NONNULL_END
