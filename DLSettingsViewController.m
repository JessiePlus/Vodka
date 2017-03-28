//
//  DLSettingsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/26.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLSettingsViewController.h"
#import <Masonry.h>
#import "DLSettingInfoCell.h"
#import "DLSettingInfoSwitchCell.h"

static NSString *const kSettingInfoCell = @"kSettingInfoCell";
static NSString *const kSettingInfoSwitchCell = @"kSettingInfoSwitchCell";


@interface DLSettingsViewController ()<UITableViewDelegate, UITableViewDataSource>

//用户信息列表
@property (nonatomic) UITableView *userInfoListView;


@end

@implementation DLSettingsViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"DLSettingsViewController init");
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"DLSettingsViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.userInfoListView];
    
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Settings", comment: "");
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 24, 24);
    [leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItems = @[leftBarBtn];
        
    [self.userInfoListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    
    self.userInfoListView.backgroundColor = [UIColor whiteColor];
    
    self.userInfoListView.dataSource = self;
    self.userInfoListView.delegate = self;
    
    
    
    
}

-(UITableView *)userInfoListView {
    if (!_userInfoListView) {
        _userInfoListView = [[UITableView alloc] initWithFrame:CGRectZero];
        _userInfoListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_userInfoListView registerClass:[DLSettingInfoCell class] forCellReuseIdentifier:kSettingInfoCell];
        [_userInfoListView registerClass:[DLSettingInfoSwitchCell class] forCellReuseIdentifier:kSettingInfoSwitchCell];
        
    }
    
    
    return _userInfoListView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        return 2;
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        
        switch (row) {
            case 0:
            {
                DLSettingInfoSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingInfoSwitchCell forIndexPath:indexPath];
                [cell.titleLab setText:NSLocalizedString(@"Push comments", comment: "")];

                return cell;
            }
                break;
            case 1:
            {
                DLSettingInfoSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingInfoSwitchCell forIndexPath:indexPath];
                [cell.titleLab setText:NSLocalizedString(@"Push messages", comment: "")];
                
                return cell;
            }
                break;
            case 2:
            {
                DLSettingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingInfoCell forIndexPath:indexPath];
                [cell.titleLab setText:NSLocalizedString(@"Clean cache", comment: "")];
                
                return cell;
            }
                break;
            case 3:
            {
                DLSettingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingInfoCell forIndexPath:indexPath];
                [cell.titleLab setText:NSLocalizedString(@"Evaluate", comment: "")];
                
                return cell;
            }
                break;
            default:
                break;
        }
    }
    
    if (section == 1) {
        
        switch (row) {
            case 0:
            {
                DLSettingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingInfoCell forIndexPath:indexPath];
                [cell.titleLab setText:NSLocalizedString(@"User Agreement", comment: "")];
                
                return cell;
            }
                break;
            case 1:
            {
                DLSettingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingInfoCell forIndexPath:indexPath];
                [cell.titleLab setText:NSLocalizedString(@"Privacy Policy", comment: "")];
                
                return cell;
            }
                break;
            default:
                break;
        }
    }
    
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 0;
    }
    
    return 20;
    
}


-(void)leftBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
