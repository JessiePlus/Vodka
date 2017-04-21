//
//  DLFeedsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedSearchListViewController.h"
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

static NSString *const kDLFeedInfoCell = @"DLFeedInfoCell";

@interface DLFeedSearchListViewController ()<UITableViewDelegate, UITableViewDataSource>
//用户信息列表
@property (nonatomic) UITableView *feedsListView;

@property (nonatomic) NSMutableArray <DLFeedItem *> *feedItemList;
//计算高度
@property (nonatomic, strong) UITableViewCell *templateCell;

@property (nonatomic) UISearchController *searchController;

@end

@implementation DLFeedSearchListViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"DLFeedSearchListViewController init");
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"DLFeedSearchListViewController dealloc");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.feedsListView];
    
    [self.feedsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    
    self.feedsListView.backgroundColor = [UIColor whiteColor];
    self.feedsListView.dataSource = self;
    self.feedsListView.delegate = self;

    self.templateCell = [self.feedsListView dequeueReusableCellWithIdentifier:kDLFeedInfoCell];
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
    
    DLFeedItem *feedItem = self.feedItemList[row];
    
    DLFeedViewController *feedViewController = [[DLFeedViewController alloc] init];
    feedViewController.feedItem = feedItem;
    
    feedViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feedViewController animated:YES];
    
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //查询数据库
        NSArray <DLFeedItem *>*searchResults = [DLFeedItem findByCriteria:[NSString stringWithFormat:@" WHERE content LIKE '%%%@%%' or title LIKE '%%%@%%'",searchString, searchString]];
        
        self.feedItemList = [searchResults mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.feedsListView reloadData];
        });
    });
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];

}


@end
