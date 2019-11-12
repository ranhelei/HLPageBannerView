//
//  ViewController.m
//  HLPageBannerView
//
//  Created by 冉合磊 on 2019/11/12.
//  Copyright © 2019 冉合磊. All rights reserved.
//

#import "ViewController.h"
#import "HLPageBannerView.h"
@interface ViewController ()<HLPageBannerViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HLPageBannerConfigure *configure = [[HLPageBannerConfigure alloc] init];
    HLPageBannerView *bannerView = [[HLPageBannerView alloc] initWithFrame:[UIScreen mainScreen].bounds delegate:self configure:configure];
    bannerView.listArray = self.listArr;
    [self.view addSubview:bannerView];
}

- (UITableView *)HLTableViewForPageBanner {
    return self.tableView;
}

- (void)HLBannerImageTapAction:(NSInteger)index {
    NSLog(@"%ld",(long)index);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

//- (NSArray *)listArr {
//
//    if (!_listArr) {
//        NSMutableArray *arr = [NSMutableArray array];
//        HLPageBannerModel *model1 = [[HLPageBannerModel alloc] init];
//        model1.imgUrl = @"http://ci.xiaohongshu.com/61b8c679-729a-41e2-90ec-ae8ae7b2b057@r_1280w_1280h.jpg";
//        model1.width = 884;
//        model1.height = 1178;
//        HLPageBannerModel *model2 = [[HLPageBannerModel alloc] init];
//        model2.imgUrl = @"http://ci.xiaohongshu.com/53e6dba6-a3fe-458f-9b98-e19ecb0105b7@r_1280w_1280h.jpg";
//        model2.width = 886;
//        model2.height = 1045;
//
//        HLPageBannerModel *model3 = [[HLPageBannerModel alloc] init];
//        model3.imgUrl = @"http://ci.xiaohongshu.com/547706bd-5d2d-4949-909f-4b7c237efc60@r_1280w_1280h.jpg";
//        model3.width = 886;
//        model3.height = 1181;
//
//        HLPageBannerModel *model4 = [[HLPageBannerModel alloc] init];
//        model4.imgUrl = @"http://ci.xiaohongshu.com/dce83cb1-bf3b-4c6a-a89a-28a19c35025d@r_1280w_1280h.jpg";
//        model4.width = 886;
//        model4.height = 995;
//
//        HLPageBannerModel *model5 = [[HLPageBannerModel alloc] init];
//        model5.imgUrl = @"http://ci.xiaohongshu.com/06c8e56c-0557-40a8-86a4-5337932f0eea@r_1280w_1280h.jpg";
//        model5.width = 1095;
//        model5.height = 1280;
//        [arr addObject:model1];
//        [arr addObject:model2];
//        [arr addObject:model3];
//        [arr addObject:model4];
//        [arr addObject:model5];
//
//        _listArr = [arr copy];
//    }
//    return _listArr;
//}


- (NSArray *)listArr {
    if (!_listArr) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dataSource" ofType:@"txt"];
        NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *temArr = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            HLPageBannerModel *model = [[HLPageBannerModel alloc] init];
            model.imgUrl = dic[@"url"];
            model.width = [dic[@"width"] floatValue];
            model.height = [dic[@"height"] floatValue];
            [temArr addObject:model];
        }
        _listArr = [temArr copy];
    }
    return _listArr;
}

@end
