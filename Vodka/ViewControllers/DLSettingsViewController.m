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
#import "DLSettingClickCell.h"
#import "DLFeedItem.h"
#import "DLFeedInfo.h"
#import "AppUtil.h"
#import <KINWebBrowserViewController.h>
#import <MBProgressHUD.h>
#import "VodkaUserDefaults.h"
#import "LKDBTool.h"
#import "DLRSSGroup.h"
#import "DLRSS.h"

static NSString *const kSettingInfoCell = @"kSettingInfoCell";
static NSString *const kSettingInfoSwitchCell = @"kSettingInfoSwitchCell";
static NSString *const kDLSettingClickCell = @"kDLSettingClickCell";



@interface DLSettingsViewController ()<UITableViewDelegate, UITableViewDataSource>

//用户信息列表
@property (nonatomic) UITableView *userInfoListView;


@end

@implementation DLSettingsViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"DLSettingsViewController init");
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"DLSettingsViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Settings", comment: "");

    [self.view addSubview:self.userInfoListView];
 
    [self.userInfoListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
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
        [_userInfoListView registerClass:[DLSettingClickCell class] forCellReuseIdentifier:kDLSettingClickCell];

        
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
        return 1;
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
                [cell.titleLab setText:NSLocalizedString(@"Push messages", comment: "")];
                
                return cell;
            }
                break;
            case 1:
            {
                DLSettingClickCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLSettingClickCell forIndexPath:indexPath];
                [cell.titleLab setText:NSLocalizedString(@"Clean cache", comment: "")];
                
                return cell;
            }
                break;
            case 2:
            {
                DLSettingClickCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLSettingClickCell forIndexPath:indexPath];
                [cell.titleLab setText:NSLocalizedString(@"Logout", comment: "")];
                
                return cell;
            }
                break;
            case 3:
            {
                DLSettingClickCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLSettingClickCell forIndexPath:indexPath];
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
                [cell.titleLab setText:NSLocalizedString(@"License", comment: "")];
                
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
            case 1:
            {
                //清除缓存
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = NSLocalizedString(@"Clear cache", comment: "");
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [DLFeedInfo clearTable];
                    [DLFeedItem clearTable];
                    
                    [DLRSSGroup clearTable];
                    [DLRSS clearTable];

                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:[AppUtil notificationNameDeleteFeed] object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:[AppUtil notificationNameAddRSSGroup] object:nil userInfo:nil];

                    });
                    
                });

            }
                break;
            case 2:
            {
                //退出登录
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeAnnularDeterminate;
                hud.label.text = NSLocalizedString(@"Logout", comment: "");
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    VodkaUserDefaults *userDefaults= [VodkaUserDefaults sharedUserDefaults];
                    [userDefaults setAccessToken:nil];
                    [userDefaults setName:nil];
                    [userDefaults setUserID:nil];

                    [[LKDBTool shareInstance] changeDBWithDirectoryName:nil];

                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                        [[NSNotificationCenter defaultCenter] postNotificationName:[AppUtil notificationNameLogout] object:nil userInfo:nil];
                    });
                    
                });
                
            }
                break;
            case 3:
            {
                //给我评分
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1229337758"] options:@{} completionHandler:nil];

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
                //开源许可
                KINWebBrowserViewController *webViewController = [[KINWebBrowserViewController alloc]init];
                [self.navigationController pushViewController:webViewController animated:YES];
                
                webViewController.title = NSLocalizedString(@"License", comment: "");
                webViewController.showsPageTitleInNavigationBar = NO;
                NSString *htmlString = [self readResourceContent:@"licence.html"];
                [webViewController loadHTMLString:htmlString];
            }
                break;

            default:
                break;
        }
    }

    
}


-(void)leftBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)readResourceContent:(NSString*)name{
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
    NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if(!string)return @"";
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
