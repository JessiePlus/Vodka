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
#import "LKDBSQLState.h"
#import "DLFeedSearchListViewController.h"

static const int kPageCount = 10;
static NSString *const kDLFeedInfoCell = @"DLFeedInfoCell";

@interface DLFeedListViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>
//用户信息列表
@property (nonatomic) UITableView *feedsListView;
@property (nonatomic) NSMutableArray <DLFeedItem *> *feedItemList;

@property (strong,nonatomic) DLFeedFetcher *feedFetcher;

//计算高度
@property (nonatomic, strong) UITableViewCell *templateCell;

//搜索
@property (nonatomic) UISearchController *searchController;
@property (nonatomic, strong) DLFeedSearchListViewController *feedSearchListViewController;


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
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tryUpdateDeleteFeed:) name:[AppUtil notificationNameDeleteFeed] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tryUpdateDeleteFeed:) name:[AppUtil notificationNameLogout] object:nil];

    
    _feedSearchListViewController = [[DLFeedSearchListViewController alloc] init];
    
    self.feedSearchListViewController.feedsListView.delegate = self;
    
    _feedFetcher = [[DLFeedFetcher alloc] init];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.definesPresentationContext = YES;

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
    
    self.feedsListView.tableHeaderView = self.searchController.searchBar;


    
    self.templateCell = [self.feedsListView dequeueReusableCellWithIdentifier:kDLFeedInfoCell];
    
    __weak __typeof__(self) weakSelf = self;
    self.feedsListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _feedFetcher.onStopLoadFeeds = ^{
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSArray <DLFeedItem *> *feedItems = [DLFeedItem findByCriteria:[NSString stringWithFormat:@"where pk_id > %d limit %d",0 ,kPageCount]];
                weakSelf.feedItemList = [feedItems mutableCopy];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.feedsListView.mj_header endRefreshing];
                    [weakSelf.feedsListView reloadData];
                });
            });
        };
        
        //请求feeds
        [_feedFetcher loadFeeds];

    }];
    
    self.feedsListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            int pk_id = ((DLFeedItem *)[weakSelf.feedItemList lastObject]).pk_id;
            NSArray <DLFeedItem *> *feedItems = [DLFeedItem findByCriteria:[NSString stringWithFormat:@"where pk_id > %d limit %d", pk_id, kPageCount]];
            [weakSelf.feedItemList addObjectsFromArray: feedItems];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.feedsListView.mj_footer endRefreshing];
                [weakSelf.feedsListView reloadData];
            });
        });
        
    }];
  
    [self tryUpdateDeleteFeed:nil];
  
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

-(UISearchController *)searchController {
    if (!_searchController) {
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.feedSearchListViewController];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;

        _searchController.searchBar.delegate = self;
        [_searchController.searchBar sizeToFit];

        

    }

    return _searchController;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.feedItemList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    DLFeedItem *feedItem = (tableView == self.feedsListView) ?
    self.feedItemList[row] : self.feedSearchListViewController.feedItemList[row];
    
    DLFeedInfoCell *cell = (DLFeedInfoCell *)self.templateCell;
    cell.itemTitleLab.text = feedItem.title ? [feedItem.title stringByConvertingHTMLToPlainText] : @"[No Title]";
    cell.itemDateLab.text = feedItem.date ? [feedItem.date stringByConvertingHTMLToPlainText] : @"[No Date]";
    cell.infoTitleLab.text = feedItem.fi_feedUrl_fk ? [feedItem.fi_feedUrl_fk stringByConvertingHTMLToPlainText] : @"[No FeedUrl]";

    CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
    
    return cellHeight;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    
    DLFeedItem *feedItem = self.feedItemList[row];
    
    DLFeedInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLFeedInfoCell forIndexPath:indexPath];
    if (cell) {
        cell.itemTitleLab.text = feedItem.title ? [feedItem.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        cell.itemDateLab.text = feedItem.date ? [feedItem.date stringByConvertingHTMLToPlainText] : @"[No Date]";
        cell.infoTitleLab.text = feedItem.fi_feedUrl_fk ? [feedItem.fi_feedUrl_fk stringByConvertingHTMLToPlainText] : @"[No FeedUrl]";

        return cell;
    }

    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger row = indexPath.row;

    DLFeedItem *feedItem = (tableView == self.feedsListView) ?
    self.feedItemList[row] : self.feedSearchListViewController.feedItemList[row];
    
    DLFeedViewController *feedViewController = [[DLFeedViewController alloc] init];
    feedViewController.feedItem = feedItem;

    feedViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feedViewController animated:YES];


}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    
    DLFeedSearchListViewController *feedSearchListViewController = (DLFeedSearchListViewController *)searchController.searchResultsController;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //查询数据库
        NSArray <DLFeedItem *>*searchResults = [DLFeedItem findByCriteria:[NSString stringWithFormat:@" WHERE content LIKE '%%%@%%' or title LIKE '%%%@%%'",searchString, searchString]];
        
        feedSearchListViewController.feedItemList = [searchResults mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [feedSearchListViewController.feedsListView reloadData];
        });
    });
    
}

-(void)tryUpdateDeleteFeed:(NSNotification *)notification{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray <DLFeedItem *> *feedItems = [DLFeedItem findByCriteria:[NSString stringWithFormat:@"where pk_id > %d limit %d",0 ,kPageCount]];
        self.feedItemList = [feedItems mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.feedsListView reloadData];
        });
    });
}

@end
