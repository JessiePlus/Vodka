//
//  UserCenterViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/4.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLUserCenterViewController.h"
#import <Masonry.h>
#import "DLSettingInfoCell.h"
#import "DLUserInfoHeaderCell.h"
#import "DLUserInfoSwitchCell.h"
#import "DLSignInViewController.h"
#import "DLSettingsViewController.h"
#import "VodkaUserDefaults.h"
#import "AppUtil.h"
#import "DLSettingClickCell.h"
#import "DLFeedbackViewController.h"


static NSString *const kSettingInfoCell = @"kSettingInfoCell";
static NSString *const kUserInfoHeaderCell = @"kUserInfoHeaderCell";
static NSString *const kUserInfoSwitchCell = @"kUserInfoSwitchCell";
static NSString *const kDLSettingClickCell = @"kDLSettingClickCell";



@interface DLUserCenterViewController () <UITableViewDelegate, UITableViewDataSource>

//用户信息列表
@property (nonatomic) UITableView *userInfoListView;

@property (nonatomic, assign) BOOL bSignIn;



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
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tryUpdateSignIn:) name:[AppUtil notificationNameSignIn] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tryUpdateSignIn:) name:[AppUtil notificationNameLogout] object:nil];


    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self tryUpdateSignIn:nil];

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
        [_userInfoListView registerClass:[DLSettingInfoCell class] forCellReuseIdentifier:kSettingInfoCell];
        [_userInfoListView registerClass:[DLUserInfoHeaderCell class] forCellReuseIdentifier:kUserInfoHeaderCell];
        [_userInfoListView registerClass:[DLUserInfoSwitchCell class] forCellReuseIdentifier:kUserInfoSwitchCell];
        [_userInfoListView registerClass:[DLSettingClickCell class] forCellReuseIdentifier:kDLSettingClickCell];

        
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
        return 1;
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
                
                if (_bSignIn) {
                    VodkaUserDefaults *userDefaults= [VodkaUserDefaults sharedUserDefaults];
                    NSString *name = [userDefaults name];
                    
                    [cell.titleLab setText:name];
                } else {
                    [cell.titleLab setText:NSLocalizedString(@"Click portrait to sign in", comment: "")];
                }
                

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
                [cell.titleLab setText:NSLocalizedString(@"Feedback", comment: "")];
                
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
                DLSettingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingInfoCell forIndexPath:indexPath];
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
                if (!_bSignIn) {
                    DLSignInViewController *loginViewController = [[DLSignInViewController alloc] init];
                    UINavigationController *navLoginController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
                    
                    [self presentViewController:navLoginController animated:YES completion:nil];
                }

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
                //反馈建议
                DLFeedbackViewController *feedbackViewController = [[DLFeedbackViewController alloc] init];
                feedbackViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:feedbackViewController animated:YES];
            }
                break;
            case 1:
            {
                //推荐给好友
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

-(void)tryUpdateSignIn:(NSNotification *)notification{
    
    VodkaUserDefaults *userDefaults= [VodkaUserDefaults sharedUserDefaults];
    NSString *accessToken = [userDefaults accessToken];
    
    _bSignIn = accessToken?YES:NO;
    
    if (_bSignIn) {
        //导航栏
        self.navigationItem.title = NSLocalizedString(@"Me", comment: "");
    } else {
        //导航栏
        self.navigationItem.title = NSLocalizedString(@"Not signed in", comment: "");
    }
    
    [self.userInfoListView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
