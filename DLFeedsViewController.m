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
#import "DLFeedEditViewController.h"
#import <XMNetworking/XMNetworking.h>

static NSString *const kDLFeedInfoCell = @"DLFeedInfoCell";

@interface DLFeedsViewController ()<UITableViewDelegate, UITableViewDataSource>

//用户信息列表
@property (nonatomic) UITableView *feedsListView;

@property (nonatomic) NSMutableArray <DLFeed *>*feedsList;

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
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 24, 24);
    [rightBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];

    [self.feedsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    
    self.feedsListView.backgroundColor = [UIColor whiteColor];
    self.feedsListView.dataSource = self;
    self.feedsListView.delegate = self;
    
    self.feedsListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.feedsListView.mj_header endRefreshing];
        
    }];
    
    self.templateCell = [self.feedsListView dequeueReusableCellWithIdentifier:kDLFeedInfoCell];

    if (!_feedsList) {
        _feedsList = [[NSMutableArray alloc] init];
    }
    
    
    //请求商品的种类
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"classes/Feeds";
        request.parameters = @{};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodGET;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {

        NSArray *feedsDicList = responseObject[@"results"];
        
        for (NSInteger i = 0; i < feedsDicList.count; i ++) {
            NSDictionary *feedDic = feedsDicList[i];
            
            NSString *objectId = feedDic[@"objectId"];
            NSString *nickName = feedDic[@"nickName"];
            NSString *msgContent = feedDic[@"msgContent"];
            NSString *avatarImageUrl = feedDic[@"avatarImageUrl"];
            NSNumber *likeNum = feedDic[@"likeNum"];
            NSNumber *commentNum = feedDic[@"commentNum"];

            DLFeed *feed = [[DLFeed alloc] init];
            feed.objectId = objectId;
            feed.nickName = nickName;
            feed.msgContent = msgContent;
            feed.avatarImageUrl = [NSURL URLWithString:avatarImageUrl];
            feed.likeNum = [likeNum intValue];
            feed.commentNum = [commentNum intValue];
            
            [self.feedsList addObject:feed];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.feedsListView reloadData];
            });
        
        }
    
    
    
    } onFailure:^(NSError *error) {
        NSLog(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        NSLog(@"onFinished");
    }];
    
    
    
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
    return self.feedsList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    

    DLFeed *feedInfo = self.feedsList[row];
    
    DLFeedInfoCell *cell = (DLFeedInfoCell *)self.templateCell;
    [cell.nickNameLab setText:feedInfo.nickName];
    [cell.msgContentLab setText:feedInfo.msgContent];
    
    if (feedInfo.likeNum > 0) {
        [cell.likeNumLab setText:[NSString stringWithFormat:@"%d", feedInfo.likeNum]];
    }
    
    if (feedInfo.commentNum > 0) {
        [cell.commentNumLab setText:[NSString stringWithFormat:@"%d", feedInfo.commentNum]];
    }

    CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
    
    return cellHeight;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    DLFeed *feedInfo = self.feedsList[row];
    
    DLFeedInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLFeedInfoCell forIndexPath:indexPath];
    
    [cell.avatarImageView sd_setImageWithURL:feedInfo.avatarImageUrl placeholderImage:[UIImage imageNamed:@""]];
    [cell.nickNameLab setText:feedInfo.nickName];
    [cell.msgContentLab setText:feedInfo.msgContent];
    
    if (feedInfo.likeNum > 0) {
        [cell.likeNumLab setText:[NSString stringWithFormat:@"%d", feedInfo.likeNum]];
    }
    
    if (feedInfo.commentNum > 0) {
        [cell.commentNumLab setText:[NSString stringWithFormat:@"%d", feedInfo.commentNum]];
    }
    
    
    return cell;
    
    
}

-(void)rightBtnClicked {

    DLFeedEditViewController *feedEditViewController = [[DLFeedEditViewController alloc] init];
    
    UINavigationController *navFeedEditController = [[UINavigationController alloc] initWithRootViewController:feedEditViewController];
    
    [self presentViewController:navFeedEditController animated:YES completion:nil];
    
    
}


@end
