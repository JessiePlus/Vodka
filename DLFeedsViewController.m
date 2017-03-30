//
//  DLFeedsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedsViewController.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "DLFeed.h"
#import "DLFeedInfoCell.h"
#import <XMNetworking/XMNetworking.h>
#import <MWFeedParser.h>
#import <NSString+HTML.h>

static NSString *const kDLFeedInfoCell = @"DLFeedInfoCell";

@interface DLFeedsViewController ()<UITableViewDelegate, UITableViewDataSource, MWFeedParserDelegate> {
    MWFeedParser *feedParser;
}

//用户信息列表
@property (nonatomic) UITableView *feedsListView;

@property (nonatomic) MWFeedInfo *feedInfo;//feed的简介
@property (nonatomic) NSMutableArray <MWFeedItem *>*feedItemList;//feed的item

@property (nonatomic) NSDateFormatter *dateFormatter;


//计算高度
@property (nonatomic, strong) UITableViewCell *templateCell;

@end

@implementation DLFeedsViewController
-(instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"DLFeedsViewController init");
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"DLFeedsViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    
    
    [self.view addSubview:self.feedsListView];

    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Feeds", comment: "");

    [self.feedsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    
    self.feedsListView.backgroundColor = [UIColor whiteColor];
    self.feedsListView.dataSource = self;
    self.feedsListView.delegate = self;
    

    
    self.templateCell = [self.feedsListView dequeueReusableCellWithIdentifier:kDLFeedInfoCell];

    
    if (!_feedItemList) {
        _feedItemList = [[NSMutableArray alloc] init];
    }
    
    _dateFormatter = [[NSDateFormatter alloc]init];
    [_dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    self.feedsListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //请求feeds
        NSURL *feedURL = [NSURL URLWithString:@"http://blog.devtang.com/atom.xml"];
        feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
        feedParser.delegate = self;
        feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
        feedParser.connectionType = ConnectionTypeAsynchronously;
        [feedParser parse];
        
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
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    MWFeedInfo *feedInfo = self.feedInfo;
    MWFeedItem *feedItem = self.feedItemList[row];

    DLFeedInfoCell *cell = (DLFeedInfoCell *)self.templateCell;

    cell.infoTitleLab.text = feedInfo.title ? [feedInfo.title stringByConvertingHTMLToPlainText] : @"[No Title]";
    cell.itemTitleLab.text = feedItem.title ? [feedItem.title stringByConvertingHTMLToPlainText] : @"[No Title]";
    cell.itemDateLab.text = feedItem.date ? [_dateFormatter stringFromDate:feedItem.date] : @"[No Date]";

    CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
    
    return cellHeight;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    MWFeedInfo *feedInfo = self.feedInfo;
    MWFeedItem *feedItem = self.feedItemList[row];
    
    DLFeedInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLFeedInfoCell forIndexPath:indexPath];
    if (cell) {
        cell.infoTitleLab.text = feedInfo.title ? [feedInfo.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        cell.itemTitleLab.text = feedItem.title ? [feedItem.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        cell.itemDateLab.text = feedItem.date ? [_dateFormatter stringFromDate:feedItem.date] : @"[No Date]";
        
        return cell;
    }

    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
}

#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"Parsed Feed Info: “%@”", info.title);
    if (info) {
        _feedInfo = info;
    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item)
        [_feedItemList addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));

    [self.feedsListView.mj_header endRefreshing];
    
    [self.feedsListView reloadData];
}

#if 0
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Finished Parsing With Error: %@", error);
    if (_feedItemList.count == 0) {
        
        self.title = @"Failed"; // Show failed message in title
        
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }

    [self.feedsListView reloadData];

}
#endif

@end
