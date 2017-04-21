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
#import "DLFeedInfoCell.h"
#import <XMNetworking/XMNetworking.h>
#import <MWFeedParser.h>
#import <NSString+HTML.h>
#import "DLFeedViewController.h"
#import "AppUtil.h"
#import "DLFeedFetcher.h"

static NSString *const kDLFeedInfoCell = @"DLFeedInfoCell";

@interface DLFeedSearchListViewController ()<UITableViewDelegate, UITableViewDataSource>

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
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    
    self.feedsListView.backgroundColor = [UIColor whiteColor];
    self.feedsListView.dataSource = self;

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


@end
