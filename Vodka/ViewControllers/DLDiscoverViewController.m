//
//  DLFeedsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLDiscoverViewController.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "DLRSSInfoCell.h"
#import <XMNetworking/XMNetworking.h>
#import <NSString+HTML.h>
#import "AppUtil.h"
#import <DLDBSQLState.h>
#import "DLRSSDicover.h"

static const int kPageCount = 10;
static NSString *const kDLRSSInfoCell = @"DLRSSInfoCell";

@interface DLDiscoverViewController ()<UITableViewDelegate, UITableViewDataSource>
    //用户信息列表
    @property (nonatomic) UITableView *RSSListView;
    @property (nonatomic) NSMutableArray <DLRSSDicover *>*RSSItemList;
    
    //计算高度
    @property (nonatomic, strong) UITableViewCell *templateCell;
    
    @end

@implementation DLDiscoverViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"DLDiscoverViewController init");
    }
    
    return self;
}
    
-(void)dealloc {
    DDLogInfo(@"DLDiscoverViewController dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.RSSListView];
    
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Discover", comment: "");
    
    [self.RSSListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    
    self.RSSListView.backgroundColor = [UIColor whiteColor];
    self.RSSListView.dataSource = self;
    self.RSSListView.delegate = self;

    
    
    self.templateCell = [self.RSSListView dequeueReusableCellWithIdentifier:kDLRSSInfoCell];
    
    __weak __typeof__(self) weakSelf = self;
    self.RSSListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.RSSListView.mj_header endRefreshing];
                [weakSelf.RSSListView reloadData];
            });
        });
        
    }];
    
    self.RSSListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.RSSListView.mj_footer endRefreshing];
                [weakSelf.RSSListView reloadData];
            });
        });
        
    }];
    
    [self tryUpdateDeleteFeed:nil];
    
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
-(UITableView *)RSSListView {
    if (!_RSSListView) {
        _RSSListView = [[UITableView alloc] initWithFrame:CGRectZero];
        _RSSListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_RSSListView registerClass:[DLRSSInfoCell class] forCellReuseIdentifier:kDLRSSInfoCell];
        
    }
    
    
    return _RSSListView;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.RSSItemList.count;
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    DLRSSDicover *RSSItem = self.RSSItemList[row];
    
    DLRSSInfoCell *cell = (DLRSSInfoCell *)self.templateCell;
    
    //config cell
    cell.nameLab.text = RSSItem.name;
    cell.feedUrlLab.text = RSSItem.feedUrl;
    cell.discripLab.text = RSSItem.discrip;
    
    CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
    
    return cellHeight;
    
}
    
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    
    DLRSSDicover *RSSItem = self.RSSItemList[row];
    
    DLRSSInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLRSSInfoCell forIndexPath:indexPath];
    if (cell) {
        
        //config cell
        cell.nameLab.text = RSSItem.name;
        cell.feedUrlLab.text = RSSItem.feedUrl;
        cell.discripLab.text = RSSItem.discrip;
        
        return cell;
    }
    
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
}
    
-(void)tryUpdateDeleteFeed:(NSNotification *)notification {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray <DLRSSDicover *> *RSSItems = [DLRSSDicover findByCriteria:[NSString stringWithFormat:@"where pk_id > %d limit %d",0 ,kPageCount]];
        self.RSSItemList = [RSSItems mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.RSSListView reloadData];
        });
    });
}
    
    @end
