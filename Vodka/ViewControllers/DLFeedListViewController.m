//
//  DLFeedsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedListViewController.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "DLFeedInfo.h"
#import "DLFeedItem.h"
#import "DLFeedInfoCell.h"
#import <XMNetworking/XMNetworking.h>
#import <MWFeedParser.h>
#import <NSString+HTML.h>
#import "DLFeedViewController.h"
#import "AppUtil.h"
#import "DLFeedFetcher.h"

static const NSUInteger kPageCount = 5;
static NSString *const kDLFeedInfoCell = @"DLFeedInfoCell";

@interface DLFeedListViewController ()<UITableViewDelegate, UITableViewDataSource>
//用户信息列表
@property (nonatomic) UITableView *feedsListView;

@property (strong,nonatomic) DLFeedFetcher *feedFetcher;

@property (nonatomic) NSMutableArray <DLFeedItem *> *feedItemList;
//计算高度
@property (nonatomic, strong) UITableViewCell *templateCell;

@end

@implementation DLFeedListViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"DLFeedListViewController init");
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"DLFeedListViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
    _feedFetcher = [[DLFeedFetcher alloc] init];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.feedsListView];

    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Feeds", comment: "");

    [self.feedsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    
    self.feedsListView.backgroundColor = [UIColor whiteColor];
    self.feedsListView.dataSource = self;
    self.feedsListView.delegate = self;
    

    
    self.templateCell = [self.feedsListView dequeueReusableCellWithIdentifier:kDLFeedInfoCell];
    
    self.feedsListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //请求feeds
        [_feedFetcher loadFeeds];
        [_feedFetcher fetchItems:0 limit:kPageCount completion:^(NSArray<DLFeedItem *> *feedItems) {
            
            if (feedItems) {
                _feedItemList = [[NSMutableArray alloc] initWithArray:feedItems];
                [self.feedsListView reloadData];
            }
            
            [self.feedsListView.mj_header endRefreshing];
        }];

    }];
    
    self.feedsListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
#if 0
        int pk = ((DLFeedItem *)[_feedItemList lastObject]).pk;
        
        [_feedFetcher fetchItems:pk limit:kPageCount completion:^(NSArray<DLFeedItem *> *feedItems) {
            
            if (feedItems) {
                [self.feedItemList addObjectsFromArray: feedItems];
                [self.feedsListView reloadData];
            }
            
            
            [self.feedsListView.mj_footer endRefreshing];
        }];
#endif
        

        
    }];
    
    [self.feedsListView.mj_header beginRefreshing];

  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)feedsListView {
    if (!_feedsListView) {
        _feedsListView = [[UITableView alloc] initWithFrame:CGRectZero];
        _feedsListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_feedsListView registerClass:[DLFeedInfoCell class] forCellReuseIdentifier:kDLFeedInfoCell];

    }
    
    
    return _feedsListView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedItemList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    DLFeedItem *feedItem = self.feedItemList[row];

    DLFeedInfoCell *cell = (DLFeedInfoCell *)self.templateCell;

    cell.itemTitleLab.text = feedItem.title ? [feedItem.title stringByConvertingHTMLToPlainText] : @"[No Title]";

    CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
    
    return cellHeight;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    DLFeedItem *feedItem = self.feedItemList[row];
    
    DLFeedInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLFeedInfoCell forIndexPath:indexPath];
    if (cell) {
        cell.itemTitleLab.text = feedItem.title ? [feedItem.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        
        return cell;
    }

    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    DLFeedItem *feedItem = self.feedItemList[row];
    
    DLFeedViewController *feedViewController = [[DLFeedViewController alloc] init];
    feedViewController.feedItem = feedItem;

    feedViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feedViewController animated:YES];


}

@end
