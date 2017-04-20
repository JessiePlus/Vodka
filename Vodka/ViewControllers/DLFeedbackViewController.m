//
//  DLSettingsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/26.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedbackViewController.h"
#import <Masonry.h>
#import "DLFeedbackContentCell.h"
#import "AppUtil.h"
#import "DLFeedbackBtnCell.h"
#import <XMNetworking.h>

static NSString *const kDLFeedbackContentCell = @"kDLFeedbackContentCell";
static NSString *const kDLFeedbackBtnCell = @"kDLFeedbackBtnCell";



@interface DLFeedbackViewController ()<UITableViewDelegate, UITableViewDataSource>

//用户信息列表
@property (nonatomic) UITableView *userInfoListView;


@end

@implementation DLFeedbackViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"DLFeedbackViewController init");
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"DLFeedbackViewController dealloc");
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
        [_userInfoListView registerClass:[DLFeedbackContentCell class] forCellReuseIdentifier:kDLFeedbackContentCell];
        [_userInfoListView registerClass:[DLFeedbackBtnCell class] forCellReuseIdentifier:kDLFeedbackBtnCell];

        
        
    }
    
    
    return _userInfoListView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;

    switch (section) {
        case 0:
        {
            return 100;
        }
            break;
        case 1:
        {
            return 60;
        }
            break;
        case 2:
        {
            return 60;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        
        switch (row) {
                
            case 0:
            {
                DLFeedbackContentCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLFeedbackContentCell forIndexPath:indexPath];
                [cell.contentTF setPlaceholder:NSLocalizedString(@"Your questions", comment: "")];
                
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
                DLFeedbackContentCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLFeedbackContentCell forIndexPath:indexPath];
                [cell.contentTF setPlaceholder:NSLocalizedString(@"Your contact", comment: "")];
                
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
                DLFeedbackBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:kDLFeedbackBtnCell forIndexPath:indexPath];
                [cell.btn setTitle:NSLocalizedString(@"Send", comment: "") forState:UIControlStateNormal];
                
                [cell.btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)btnClicked:(UIButton *)sender {

    DLFeedbackContentCell *contentCell = [self.userInfoListView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *contentTF = contentCell.contentTF;
    
    
    DLFeedbackContentCell *contactCell = [self.userInfoListView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    UITextField *contactTF = contactCell.contentTF;
    
    NSString *content = contentTF.text;
    if (!content || content.length == 0) {
        return;
    }
    
    NSString *contact = contactTF.text;
    if (!contact || contact.length == 0) {
        return;
    }
    
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"feedback";
        request.parameters = @{@"status": @"open", @"content": content, @"contact":contact};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {
        
        
        [self leftBtnClicked];
        
    } onFailure:^(NSError *error) {
        DDLogError(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        DDLogInfo(@"onFinished");
    }];
    
    
    


}

-(void)leftBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
