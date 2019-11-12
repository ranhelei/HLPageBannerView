//
//  HLBannerImageView.m
//  banner
//
//  Created by 冉合磊 on 2019/10/29.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import "HLBannerImageView.h"
#import <UIImageView+WebCache.h>
@interface HLBannerImageView ()
@property (nonatomic, strong) CAGradientLayer *coverLayer;
@property (nonatomic, strong) HLPageBannerConfigure *configure;
@end
@implementation HLBannerImageView

- (instancetype)initWithFrame:(CGRect)frame configure:(HLPageBannerConfigure *)configure {
    if (self = [super initWithFrame:frame]) {
        _configure = configure;
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
        if (configure.imgShadowMask) {
            [self addCoverLayer];
        }
    }
    return self;
}

- (void)setModel:(HLPageBannerModel *)model {
    _model = model;
    [self sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
}

- (void)addCoverLayer {
    _coverLayer =  [CAGradientLayer layer];
    _coverLayer.frame = CGRectMake(0, 0, self.frame.size.width, [UIScreen mainScreen].bounds.size.height);
    _coverLayer.colors = self.configure.imgShadowColors;
    _coverLayer.startPoint = CGPointMake(0, 0);
    _coverLayer.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:_coverLayer];
}
@end
