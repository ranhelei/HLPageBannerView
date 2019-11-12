//
//  HLPageBannerView.m
//  banner
//
//  Created by 冉合磊 on 2019/10/25.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import "HLPageBannerView.h"
#import "HLBannerImageView.h"
@interface HLPageBannerView ()<HLbannerHeaderDelegate>
@property (nonatomic, weak) id<HLPageBannerViewDelegate> delegate;
@property (nonatomic, strong) HLPageBannerConfigure *configure;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HLBannerImageView *backImageView;
@property (nonatomic, assign) BOOL showBgImag;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation HLPageBannerView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id <HLPageBannerViewDelegate>)delegate configure:(HLPageBannerConfigure *)configure{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        self.configure = configure;
        if ([self.delegate respondsToSelector:@selector(HLTableViewForPageBanner)]) {
            self.tableView = [self.delegate HLTableViewForPageBanner];
            [self addSubview:self.tableView];
            self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 69)];
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.offset(0);
            }];
            if (@available(iOS 11.0, *)) {
                self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;  
            }
        } else {
            NSAssert(NO, @"请传入一个tableView");
        }
    }
    return self;
}

- (void)setListArray:(NSArray<HLPageBannerModel *> *)listArray {
    _listArray = listArray;
    if (!listArray.count) {
        return;
    }
    [self.headerView reloadWithLists:listArray];
    CGFloat height = [self getHeaderHeight:listArray.firstObject];
    self.headerView.frame = CGRectMake(0, 0, self.frame.size.width, height);
    self.tableView.tableHeaderView = self.headerView;
    [self setupBackGroundImageView];
}

#pragma mark HLbannerHeaderDelegate
- (void)HLBannerImgTap:(HLBannerImageView *)imgView {
    if ([self.delegate respondsToSelector:@selector(HLBannerImageTapAction:)]) {
        [self.delegate HLBannerImageTapAction:imgView.index];
    }
}

- (void)HLScrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger index = (NSInteger)currentOffsetX / self.frame.size.width;
    CGFloat offsetValue = currentOffsetX - self.frame.size.width * index;
    
    HLPageBannerModel *currentModel;
    HLPageBannerModel *preModel;
    if (offsetValue > 0) {//左滑
        if (index == self.listArray.count - 1) {
            return;
        }
        currentModel = self.listArray[index];
        preModel = self.listArray[index + 1];
    } else {//右滑
        if (index == 0) {
            return;
        }
        currentModel = self.listArray[index];
        preModel = self.listArray[index - 1];
    }
    [self updateHeaderHeightWithOffSetValue:offsetValue currentModel:currentModel preModel:preModel];
}

//图片索引传值，改变背景图片
- (void)HLBannerImgIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (_backImageView) {
        HLPageBannerModel *model = self.listArray[currentIndex];
        self.backImageView.model = model;
    }
}

//根据滑动计算高度
- (void)updateHeaderHeightWithOffSetValue:(CGFloat)offsetValue currentModel:(HLPageBannerModel *)currentModel preModel:(HLPageBannerModel *)preModel {
    
    CGFloat currentImgH = [self getHeaderHeight:currentModel];
    CGFloat preImgH = [self getHeaderHeight:preModel];
    CGFloat value = preImgH - currentImgH;
    CGFloat offsetX = fabs(offsetValue) / self.frame.size.width  * value;
    CGFloat realHeight = MAX((currentImgH + offsetX), self.configure.imgMinHeight);
    [self updateHeaderViewHeight:realHeight];
    [self layoutIfNeeded];
}

//更新tableHeaderView高度
- (void)updateHeaderViewHeight:(CGFloat)height {
    //去除tableview beginUpdates调用时动画，防止tableview抖动
    [UIView setAnimationsEnabled:NO];
    [self.tableView beginUpdates];
    self.headerView.frame = CGRectMake(0, 0, self.frame.size.width, height);
    [self.tableView endUpdates];
    [UIView setAnimationsEnabled:YES];
}

//根据图片宽高比计算图片高度
- (CGFloat)getHeaderHeight:(HLPageBannerModel *)model {
    CGFloat imgH = self.frame.size.width * model.height / model.width;
    imgH = isnan(imgH) ? 0 : imgH;
    imgH = MIN(imgH, self.configure.imgMaxHeight);
    imgH = MAX(imgH, self.configure.imgMinHeight);
    return imgH;
}

//监听tableview的contentoffset变化，改变背景图片高度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSValue *newvalue = change[NSKeyValueChangeNewKey];
    CGFloat newoffset_y = newvalue.UIOffsetValue.vertical;
    
    if (newoffset_y >= 0) {
        self.showBgImag = NO;
    } else {
        self.showBgImag = YES;
    }
    CGFloat height = [self getHeaderHeight:self.listArray[_currentIndex]];
    self.backImageView.frame = CGRectMake(0, 0, self.frame.size.width, height - newoffset_y);
}

- (void)setShowBgImag:(BOOL)showBgImag {
    if (_showBgImag == showBgImag) {
        return;
    }
    _showBgImag = showBgImag;
    self.headerView.alpha = showBgImag ? 0 : 1;
    self.tableView.backgroundColor = showBgImag ? [UIColor clearColor] : [UIColor whiteColor];
}

- (void)setupBackGroundImageView {
    if (!_backImageView) {
        self.backImageView = [[HLBannerImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.headerView.frame.size.height) configure:self.configure];
        self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self insertSubview:self.backImageView belowSubview:self.tableView];
    }
    self.backImageView.frame = self.headerView.frame;
    HLPageBannerModel *model = self.listArray.firstObject;
    self.backImageView.model = model;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (HLbannerHeader *)headerView {
    if (!_headerView) {
        _headerView = [[HLbannerHeader alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 250) configure:self.configure];
        _headerView.delegate = self;
    }
    return _headerView;
}
@end
