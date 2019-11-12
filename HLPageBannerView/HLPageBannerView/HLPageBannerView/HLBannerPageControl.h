//
//  HLBannerPageControl.h
//  banner
//
//  Created by 冉合磊 on 2019/10/29.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLPageBannerConfigure.h"
NS_ASSUME_NONNULL_BEGIN

@interface HLBannerPageControl : UIPageControl
- (instancetype)initWithConfigure:(HLPageBannerConfigure *)configure;

@end

NS_ASSUME_NONNULL_END
