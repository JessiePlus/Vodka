//
//  UserCenterViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/4.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLUserCenterViewController.h"
#import <Masonry.h>
#import "DLUserInfoCell.h"
#import "DLUserInfoHeaderCell.h"
#import "DLUserInfoSwitchCell.h"
#import "DLSignInViewController.h"
#import "DLSettingsViewController.h"

static NSString *const kUserInfoCell = @"kUserInfoCell";
static NSString *const kUserInfoHeaderCell = @"kUserInfoHeaderCell";
static NSString *const kUserInfoSwitchCell = @"kUserInfoSwitchCell";


@interface DLUserCenterViewController () <UITableViewDelegate, UITableViewDataSource>

//用户信息列表
@property (nonatomic) UITableView *userInfoListView;



@end

@implementation DLUserCenterViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        
        
        NSLog(@"UserCenterViewController init");
        
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"UserCenterViewController dealloc");
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.userInfoListView];

    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Not signed in", comment: "");
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 24, 24);
    [rightBtn setImage:[UIImage imageNamed:@"icon_settings"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    
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
        [_userInfoListView registerClass:[DLUserInfoCell class] forCellReuseIdentifier:kUserInfoCell];
        [_userInfoListView registerClass:[DLUserInfoHeaderCell class] forCellReuseIdentifier:kUserInfoHeaderCell];
        [_userInfoListView registerClass:[DLUserInfoSwitchCell class] forCellReuseIdentifier:kUserInfoSwitchCell];
        
    }
    
    
    return _userInfoListView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    
    if (section == 2) {
        return 1;
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        return 100;
    }
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        switch (row) {
            case 0:
            {
                DLUserInfoHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoHeaderCell forIndexPath:indexPath];
                [cell.iconImageView setImage:[UIImage imageNamed:@"default_avatar"]];
                [cell.titleLab setText:NSLocalizedString(@"Click portrait to sign in", comment: "")];
                
                cell.iconImageViewTapAction = ^() {
                
                    DLSignInViewController *loginViewController = [[DLSignInViewController alloc] init];
                    UINavigationController *navLoginController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
                    
                    [self presentViewController:navLoginController animated:YES completion:nil];
                
                
                };
                
                
                
                
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
                DLUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoCell forIndexPath:indexPath];
                [cell.iconImageView setImage:[UIImage imageNamed:@"icon_feedback"]];
                [cell.titleLab setText:NSLocalizedString(@"Feedback", comment: "")];
                
                return cell;
            }
                break;
            case 1:
            {
                DLUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoCell forIndexPath:indexPath];
                [cell.iconImageView setImage:[UIImage imageNamed:@"icon_shareAPP"]];
                [cell.titleLab setText:NSLocalizedString(@"Recommend to friends", comment: "")];
                
                return cell;
            }
                break;
            default:
                break;
        }
    }
    
    if (section == 2) {
        
        switch (row) {
            case 0:
            {
                DLUserInfoSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoSwitchCell forIndexPath:indexPath];
                [cell.iconImageView setImage:[UIImage imageNamed:@"icon_nightMode"]];
                [cell.titleLab setText:NSLocalizedString(@"Night mode", comment: "")];
                
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


-(void)rightBtnClicked {
    
    DLSettingsViewController *settingsViewController = [[DLSettingsViewController alloc] init];
    
    [self.navigationController pushViewController:settingsViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
