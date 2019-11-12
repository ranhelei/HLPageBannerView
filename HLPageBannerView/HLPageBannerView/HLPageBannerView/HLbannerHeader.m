//
//  HLbannerHeader.m
//  banner
//
//  Created by 冉合磊 on 2019/10/25.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import "HLbannerHeader.h"
#import "HLBannerPageControl.h"
@interface HLbannerHeader ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSArray<HLPageBannerModel *> *listArray;
@property (nonatomic, copy) NSArray *imgViews;
@property (nonatomic, strong) HLBannerPageControl *pageControl;
@property (nonatomic, strong) HLPageBannerConfigure *configure;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation HLbannerHeader

- (instancetype)initWithFrame:(CGRect)frame configure:(HLPageBannerConfigure *)configure {
    self = [super initWithFrame:frame];
    if (self) {
        _configure = configure;
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-10);
            make.height.offset(4.5);
        }];
    }
    return self;
}

- (void)reloadWithLists:(NSArray<HLPageBannerModel *> *)listArray {
    _listArray = listArray;
    for (UIImageView *view in self.imgViews) {
        [view removeFromSuperview];
    }
    NSMutableArray *imageViews = [NSMutableArray array];
    for (int i = 0; i < MIN(listArray.count, 9); i++) {
        HLPageBannerModel *model = listArray[i];
        HLBannerImageView *imgView = [[HLBannerImageView alloc] initWithFrame:self.frame configure:self.configure];
        imgView.model = model;
        imgView.index = i;
        [self.scrollView addSubview:imgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapAction:)];
        [imgView addGestureRecognizer:tap];
        if (i == 0) {
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.top.equalTo(self.scrollView);
                make.bottom.equalTo(self);
                make.width.equalTo(self);
            }];
        } else {
            UIImageView *preImgV = imageViews.lastObject;
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(preImgV.mas_trailing);
                make.top.equalTo(self.scrollView);
                make.bottom.equalTo(self);
                make.width.equalTo(self);
            }];
        }
        [imageViews addObject:imgView];
    }
    self.imgViews = imageViews;
    UIImageView *lastView = imageViews.lastObject;
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        make.trailing.equalTo(lastView);
    }];
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * MIN(listArray.count, 9), self.bounds.size.height);
    self.pageControl.numberOfPages = MIN(listArray.count, 9);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(HLScrollViewDidScroll:)]) {
        [self.delegate HLScrollViewDidScroll:scrollView];
    }
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = (NSInteger)(offsetX + (self.frame.size.width * 0.5)) / self.frame.size.width;
    self.currentIndex = index;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (_currentIndex == currentIndex) {
        return;
    }
    _currentIndex = currentIndex;
    self.pageControl.currentPage = currentIndex;
    if ([self.delegate respondsToSelector:@selector(HLBannerImgIndex:)]) {
        [self.delegate HLBannerImgIndex:currentIndex];
    }
}

- (void)imgTapAction:(UIGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(HLBannerImgTap:)]) {
        HLBannerImageView *imgView = (HLBannerImageView *)recognizer.view;
        [self.delegate HLBannerImgTap:imgView];
    }
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = self.configure.scrollBounces;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (HLBannerPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[HLBannerPageControl alloc] initWithConfigure:self.configure];
    }
    return _pageControl;
}
@end
