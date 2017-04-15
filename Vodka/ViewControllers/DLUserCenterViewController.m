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
        DDLogInfo(@"UserCenterViewController init");
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"UserCenterViewController dealloc");    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;

    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Not signed in", comment: "");
    
    [self.view addSubview:self.userInfoListView];

    [self.userInfoListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
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
                DLUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoCell forIndexPath:indexPath];
                [cell.iconImageView setImage:[UIImage imageNamed:@"icon_settings"]];
                [cell.titleLab setText:NSLocalizedString(@"Settings", comment: "")];
                
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        switch (row) {
            case 0:
            {
                DLSignInViewController *loginViewController = [[DLSignInViewController alloc] init];
                UINavigationController *navLoginController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
                
                [self presentViewController:navLoginController animated:YES completion:nil];

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

            }
                break;
            case 1:
            {

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
                DLSettingsViewController *settingsViewController = [[DLSettingsViewController alloc] init];
                settingsViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:settingsViewController animated:YES];
            }
                break;
                
            default:
                break;
        }
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
