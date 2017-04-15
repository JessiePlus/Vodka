//
//  DiscoverViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//
#import "DLRSSGroupViewController.h"
#import <Masonry.h>
#import "DLCategoryInfoCell.h"
#import "DLRSSGroup.h"
#import <XMNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>

#import "DLRSSSubscribeViewController.h"
#import "DLFeedAddGroupViewController.h"

#import <MJExtension.h>

static NSString *const kDLCategoryInfoCell = @"DLCategoryInfoCell";

@interface DLRSSGroupViewController () <UITableViewDelegate, UITableViewDataSource>

//分类列表
@property (nonatomic) UITableView *RSSGroupListView;
@property (nonatomic) NSMutableArray <DLRSSGroup *>*RSSGroupList;

@end

@implementation DLRSSGroupViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        
        
        DDLogInfo(@"DLRSSGroupViewController init");
        
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"DLRSSGroupViewController dealloc");
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Discover", comment: "");
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBtnClicked)];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.RSSGroupListView];
    
    [self.RSSGroupListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.centerX.equalTo(self.view);
    }];
    
    
    self.RSSGroupListView.backgroundColor = [UIColor whiteColor];
    self.RSSGroupListView.dataSource = self;
    self.RSSGroupListView.delegate = self;
    
    self.RSSGroupListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //请求RSS的种类
        [XMCenter sendRequest:^(XMRequest *request) {
            request.api = @"classes/DLRSSGroup";
            request.parameters = @{};
            request.headers = @{};
            request.httpMethod = kXMHTTPMethodGET;
            request.requestSerializerType = kXMRequestSerializerJSON;
        } onSuccess:^(id responseObject) {

            [DLRSSGroup mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"rg_id" : @"objectId",
                         @"name" : @"name",
                         };
            }];
            
            NSMutableArray <DLRSSGroup *>*RSSGroupList = [DLRSSGroup mj_objectArrayWithKeyValuesArray:responseObject[@"results"]];

            //缓存到数据库
            for (DLRSSGroup *RSSGroup in RSSGroupList) {
                [RSSGroup saveOrUpdateByColumnName:@"rg_id" AndColumnValue:RSSGroup.rg_id];
            }
            
            //更新界面
            [self.RSSGroupListView.mj_header endRefreshing];

            self.RSSGroupList = RSSGroupList;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.RSSGroupListView reloadData];
            });
            
        } onFailure:^(NSError *error) {
            DDLogError(@"onFailure: %@", error);
        } onFinished:^(id responseObject, NSError *error) {
            DDLogInfo(@"onFinished");
        }];
        
    }];
    
    // 查询出全部的RSS
    NSArray *RSSGroupList = [DLRSSGroup findAll];
    self.RSSGroupList = [RSSGroupList mutableCopy];
    
}

-(UITableView *)RSSGroupListView {
    if (!_RSSGroupListView) {
        _RSSGroupListView = [[UITableView alloc] initWithFrame:CGRectZero];
        _RSSGroupListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_RSSGroupListView registerClass:[DLCategoryInfoCell class] forCellReuseIdentifier:kDLCategoryInfoCell];
        
    }
    
    
    return _RSSGroupListView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.RSSGroupList.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    DLRSSGroup *DLRSSGroup = self.RSSGroupList[row];

    DLCategoryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLCategoryInfoCell forIndexPath:indexPath];
    if (cell) {
        [cell.titleLab setText:DLRSSGroup.name];
        
        return cell;
    }

    
    
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger row = indexPath.row;
    
    
    
    DLRSSSubscribeViewController *RSSSubscribeViewController = [[DLRSSSubscribeViewController alloc] init];
    RSSSubscribeViewController.RSSGroup = self.RSSGroupList[row];
    RSSSubscribeViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:RSSSubscribeViewController animated:YES];
    

}

-(void)rightBtnClicked {
    
    DLFeedAddGroupViewController *feedEditViewController = [[DLFeedAddGroupViewController alloc] init];
    
    [self.navigationController pushViewController:feedEditViewController animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
