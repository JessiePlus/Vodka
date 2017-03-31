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

static NSString *const kDLCategoryInfoCell = @"DLCategoryInfoCell";

@interface DLRSSGroupViewController () <UITableViewDelegate, UITableViewDataSource>

//分类列表
@property (nonatomic) UITableView *DLRSSGroupListView;
@property (nonatomic) NSMutableArray <DLRSSGroup *>*DLRSSGroupList;

@end

@implementation DLRSSGroupViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        
        
        NSLog(@"DLRSSGroupViewController init");
        
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"DLRSSGroupViewController dealloc");
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Discover", comment: "");
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 24, 24);
    [rightBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.DLRSSGroupListView];
    
    [self.DLRSSGroupListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.centerX.equalTo(self.view);
    }];
    
    
    self.DLRSSGroupListView.backgroundColor = [UIColor whiteColor];
    self.DLRSSGroupListView.dataSource = self;
    self.DLRSSGroupListView.delegate = self;
    
    self.DLRSSGroupListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //请求RSS的种类
        [XMCenter sendRequest:^(XMRequest *request) {
            request.api = @"classes/DLRSSGroup?include=allRSS&";
            request.parameters = @{};
            request.headers = @{};
            request.httpMethod = kXMHTTPMethodGET;
            request.requestSerializerType = kXMRequestSerializerJSON;
        } onSuccess:^(id responseObject) {
            
            [self.DLRSSGroupListView.mj_header endRefreshing];

            NSError *error;
            self.DLRSSGroupList = [[DLRSSGroup arrayOfModelsFromDictionaries:responseObject[@"results"] error:&error] mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.DLRSSGroupListView reloadData];
            });
            
        } onFailure:^(NSError *error) {
            NSLog(@"onFailure: %@", error);
        } onFinished:^(id responseObject, NSError *error) {
            NSLog(@"onFinished");
        }];
        
    }];
    
    [self.DLRSSGroupListView.mj_header beginRefreshing];
    
}

-(UITableView *)DLRSSGroupListView {
    if (!_DLRSSGroupListView) {
        _DLRSSGroupListView = [[UITableView alloc] initWithFrame:CGRectZero];
        _DLRSSGroupListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_DLRSSGroupListView registerClass:[DLCategoryInfoCell class] forCellReuseIdentifier:kDLCategoryInfoCell];
        
    }
    
    
    return _DLRSSGroupListView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.DLRSSGroupList.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    DLRSSGroup *DLRSSGroup = self.DLRSSGroupList[row];

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
    RSSSubscribeViewController.RSSGroup = self.DLRSSGroupList[row];
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
