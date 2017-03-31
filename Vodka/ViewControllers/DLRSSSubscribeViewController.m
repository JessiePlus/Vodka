//
//  DLRSSViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLRSSSubscribeViewController.h"
#import <Masonry.h>
#import "DLUserInfoCell.h"
#import "DLUserInfoHeaderCell.h"
#import "DLUserInfoSwitchCell.h"
#import "DLFeedAddRSSViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *const kUserInfoCell = @"kUserInfoCell";
static NSString *const kUserInfoSwitchCell = @"kUserInfoSwitchCell";

@interface DLRSSSubscribeViewController () <UITableViewDelegate, UITableViewDataSource>

//RSS订阅列表
@property (nonatomic) UITableView *RSSSubscribeListView;



@end

@implementation DLRSSSubscribeViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"DLRSSSubscribeViewController init");
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"DLRSSSubscribeViewController dealloc");    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏
    self.navigationItem.title = self.RSSGroup.name;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 24, 24);
    [leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 24, 24);
    [rightBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    self.navigationItem.leftBarButtonItems = @[leftBarBtn];
    
    
    [self.view addSubview:self.RSSSubscribeListView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self.RSSSubscribeListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.centerX.equalTo(self.view);
    }];
    
    self.RSSSubscribeListView.backgroundColor = [UIColor whiteColor];
    self.RSSSubscribeListView.dataSource = self;
    self.RSSSubscribeListView.delegate = self;

}


-(UITableView *)RSSSubscribeListView {
    if (!_RSSSubscribeListView) {
        _RSSSubscribeListView = [[UITableView alloc] initWithFrame:CGRectZero];
        _RSSSubscribeListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_RSSSubscribeListView registerClass:[DLUserInfoCell class] forCellReuseIdentifier:kUserInfoCell];
        [_RSSSubscribeListView registerClass:[DLUserInfoSwitchCell class] forCellReuseIdentifier:kUserInfoSwitchCell];
        
    }
    
    
    return _RSSSubscribeListView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    return self.RSSGroup.allRSS.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    DLRSS *RSS = self.RSSGroup.allRSS[row];
    
    DLUserInfoSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoSwitchCell forIndexPath:indexPath];
    if (cell) {
        [cell.iconImageView sd_setImageWithURL:RSS.iconUrl placeholderImage:nil];
        [cell.titleLab setText:RSS.name];
    }

    
    return cell;
    
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    
}


-(void)leftBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClicked {
    
    DLFeedAddRSSViewController *feedEditViewController = [[DLFeedAddRSSViewController alloc] init];
    
    [self.navigationController pushViewController:feedEditViewController animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
