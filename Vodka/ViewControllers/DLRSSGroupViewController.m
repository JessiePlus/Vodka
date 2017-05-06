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
#import "DLAddRSSGroupViewController.h"

#import <MJExtension.h>
#import "VodkaUserDefaults.h"
#import "AppUtil.h"
#import <DLDBSQLState.h>
#import "DLRSS.h"
#import "DLFeedInfo.h"
#import "DLFeedItem.h"
#import "DLSignInViewController.h"

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
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tryUpdateAddRSSGroup:) name:[AppUtil notificationNameAddRSSGroup] object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tryUpdateAddRSSGroup:) name:[AppUtil notificationNameLogout] object:nil];

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

        VodkaUserDefaults *userDefaults= [VodkaUserDefaults sharedUserDefaults];
        NSString *userID = [userDefaults userID];
        
        [XMCenter sendRequest:^(XMRequest *request) {
            request.api = @"classes/DLRSSGroup";
            request.parameters = @{@"where":[NSString stringWithFormat:@"{\"author\":{\"__type\":\"Pointer\",\"className\":\"_User\",\"objectId\":\"%@\"}}", userID]};
            request.headers = @{};
            request.httpMethod = kXMHTTPMethodGET;
            request.requestSerializerType = kXMRequestSerializerJSON;
        } onSuccess:^(id responseObject) {

            [DLRSSGroup mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{
                         @"rg_id" : @"objectId",
                         @"name" : @"name",
                         @"u_id_fk" : @"author.objectId",

                         };
            }];
            
            NSMutableArray <DLRSSGroup *>*RSSGroupList = [DLRSSGroup mj_objectArrayWithKeyValuesArray:responseObject[@"results"]];

            self.RSSGroupList = RSSGroupList;
            [self.RSSGroupListView reloadData];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //缓存到数据库
                for (DLRSSGroup *RSSGroup in RSSGroupList) {
                    [RSSGroup saveOrUpdateByColumnName:@"rg_id" AndColumnValue:RSSGroup.rg_id];
                }
            });

        } onFailure:^(NSError *error) {
            DDLogError(@"onFailure: %@", error);
        } onFinished:^(id responseObject, NSError *error) {
            DDLogInfo(@"onFinished");
            //更新界面
            [self.RSSGroupListView.mj_header endRefreshing];
        }];
        
    }];
    
    [self tryUpdateAddRSSGroup:nil];
    

    
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;

    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        
        
        VodkaUserDefaults *userDefaults= [VodkaUserDefaults sharedUserDefaults];
        NSString *accessToken = [userDefaults accessToken];
        
        DLRSSGroup *RSSGroup = self.RSSGroupList[row];
        
        [XMCenter sendRequest:^(XMRequest *request) {
            request.api = [NSString stringWithFormat:@"classes/DLRSSGroup/%@", RSSGroup.rg_id];
            request.parameters = @{};
            request.headers = @{@"X-LC-Session":accessToken};
            request.httpMethod = kXMHTTPMethodDELETE;
            request.requestSerializerType = kXMRequestSerializerJSON;
        } onSuccess:^(id responseObject) {
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                DLDBSQLState *query = [[DLDBSQLState alloc] object:[DLRSS class] type:WHERE key:@"rg_id_fk" opt:@"=" value:RSSGroup.rg_id];
                NSArray <DLRSS *>*RSSList = [DLRSS findByCriteria:[query sqlOptionStr]];
                
                for (DLRSS *RSS in RSSList) {
                    
                    //同时删除该RSS的所有DLFeedInfo DLFeedItem缓存
                    DLDBSQLState *query3 = [[DLDBSQLState alloc] object:[DLFeedInfo class] type:WHERE key:@"feedUrl" opt:@"=" value:RSS.feedUrl];
                    [DLFeedInfo deleteObjectsByCriteria:[query3 sqlOptionStr]];
                    
                    DLDBSQLState *query4 = [[DLDBSQLState alloc] object:[DLFeedItem class] type:WHERE key:@"fi_feedUrl_fk" opt:@"=" value:RSS.feedUrl];
                    [DLFeedItem deleteObjectsByCriteria:[query4 sqlOptionStr]];
                    
                    [RSS deleteObject];
                }
                
                DLDBSQLState *query1 = [[DLDBSQLState alloc] object:[DLRSSGroup class] type:WHERE key:@"rg_id" opt:@"=" value:RSSGroup.rg_id];
                [DLRSSGroup deleteObjectsByCriteria:[query1 sqlOptionStr]];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.RSSGroupList removeObject:RSSGroup];
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:[AppUtil notificationNameDeleteFeed] object:nil userInfo:nil];
                    
                });
                
            });

        } onFailure:^(NSError *error) {
            DDLogError(@"onFailure: %@", error);
        } onFinished:^(id responseObject, NSError *error) {
            DDLogInfo(@"onFinished");
        }];
        
        

    }
}

-(void)rightBtnClicked {
    
    VodkaUserDefaults *userDefaults= [VodkaUserDefaults sharedUserDefaults];
    NSString *accessToken = [userDefaults accessToken];
    
    BOOL bSignIn = accessToken?YES:NO;
    
    if (!bSignIn) {
        DLSignInViewController *loginViewController = [[DLSignInViewController alloc] init];
        UINavigationController *navLoginController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        
        [self presentViewController:navLoginController animated:YES completion:nil];
        
        return;
    }
    
    
    DLAddRSSGroupViewController *feedEditViewController = [[DLAddRSSGroupViewController alloc] init];
    feedEditViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feedEditViewController animated:YES];
    
    
}

-(void)tryUpdateAddRSSGroup:(NSNotification *)notification{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *RSSGroupList = [DLRSSGroup findAll];
        self.RSSGroupList = [RSSGroupList mutableCopy];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.RSSGroupListView reloadData];            
        });
        
    });
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
