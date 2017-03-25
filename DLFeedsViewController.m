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
#import "VodkaService+Feeds.h"
#import "DLFeedEditViewController.h"

static NSString *const kDLFeedInfoCell = @"DLFeedInfoCell";

@interface DLFeedsViewController ()<UITableViewDelegate, UITableViewDataSource>
//自定义导航栏
@property (nonatomic) UINavigationBar *customNavigationBar;
@property (nonatomic) UINavigationItem *customNavigationItem;

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.customNavigationBar];
    [self.view addSubview:self.feedsListView];


    //导航栏布局
    [self.customNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@64);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];

    [self.feedsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.customNavigationBar.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    
    
    self.feedsListView.backgroundColor = [UIColor whiteColor];
    self.feedsListView.dataSource = self;
    self.feedsListView.delegate = self;
    
    self.feedsListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.feedsListView.mj_header endRefreshing];
        
    }];
    
    self.templateCell = [self.feedsListView dequeueReusableCellWithIdentifier:kDLFeedInfoCell];

    //请求茶种类
    [[VodkaService sharedManager] requestAllFeedsSuccess:^(NSArray<DLFeed *> *feedList) {
        if (!_feedsList) {
            _feedsList = [[NSMutableArray alloc] init];
        } else {
            [_feedsList removeAllObjects];
        }
        
        _feedsList = [feedList mutableCopy];
        
        [self.feedsListView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UINavigationItem *)customNavigationItem {
    if (!_customNavigationItem) {
        _customNavigationItem = [[UINavigationItem alloc] initWithTitle:NSLocalizedString(@"Feeds", comment: "")];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 24, 24);
        [rightBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        
        
        _customNavigationItem.rightBarButtonItems = @[rightBarBtn];
    }
    
    return _customNavigationItem;
}

-(UINavigationBar *)customNavigationBar {
    if (!_customNavigationBar) {
        _customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        [_customNavigationBar setItems:@[self.customNavigationItem] animated:false];
        _customNavigationBar.barTintColor = [UIColor whiteColor];
        _customNavigationBar.titleTextAttributes = @{
                                                     NSForegroundColorAttributeName:[UIColor blackColor]
                                                     
                                                     };
    }
    
    return _customNavigationBar;
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
    
    
    
    return cell;
    
    
}

-(void)rightBtnClicked {

    DLFeedEditViewController *feedEditViewController = [[DLFeedEditViewController alloc] init];
    
    [self presentViewController:feedEditViewController animated:YES completion:nil];
    
    
}


@end
