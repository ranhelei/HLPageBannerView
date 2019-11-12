//
//  HLPageBannerModel.m
//  banner
//
//  Created by 冉合磊 on 2019/10/25.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import "HLPageBannerModel.h"

@implementation HLPageBannerModel

- (CGFloat)width {
    if (_width > 0) {
        return _width;
    }
    return 375;
}

- (CGFloat)height {
    if (_height > 0) {
        return _height;
    }
    return 667;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"imgUrl" : @"url"};
}
@end
