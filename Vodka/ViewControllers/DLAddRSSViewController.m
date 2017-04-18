//
//  DLFeedEditViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/26.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLAddRSSViewController.h"
#import <Masonry.h>
#import "VodkaUserDefaults.h"
#import <XMNetworking.h>

@interface DLAddRSSViewController ()
@property (nonatomic) UITextField *RSSTF;
@property (nonatomic) UILabel *httpLab;//手机号

@end

@implementation DLAddRSSViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"DLFeedAddRSSViewController init");
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"DLFeedAddRSSViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;

    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Add RSS", comment: "");
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBtnClicked)];
    
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    [self.view addSubview:self.httpLab];

    [self.view addSubview:self.RSSTF];
    
    [self.httpLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20);
        make.left.equalTo(self.view);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
    }];
    
    [self.RSSTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20);
        make.left.equalTo(self.httpLab.mas_right);
        make.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    [self.RSSTF becomeFirstResponder];
}

-(UILabel *)httpLab {
    if (!_httpLab) {
        _httpLab = [[UILabel alloc] init];
        _httpLab.backgroundColor = [UIColor whiteColor];
        _httpLab.textAlignment = NSTextAlignmentCenter;
        _httpLab.text = NSLocalizedString(@"http://", comment: "");
    }
    return _httpLab;
}

-(UITextField *)RSSTF {
    if (!_RSSTF) {
        _RSSTF = [[UITextField alloc] init];
        _RSSTF.textAlignment = NSTextAlignmentLeft;
        _RSSTF.placeholder = NSLocalizedString(@"Input RSS address", comment: "");
        _RSSTF.backgroundColor = [UIColor whiteColor];
        _RSSTF.returnKeyType = UIReturnKeyDone;
    }
    
    return _RSSTF;
}



-(void)rightBtnClicked {
    NSString *RSS = self.RSSTF.text;
    if (!RSS || RSS.length == 0) {
        return;
    }
    
    VodkaUserDefaults *userDefaults= [VodkaUserDefaults sharedUserDefaults];
    NSString *userID = [userDefaults userID];
    
    NSString *ACLParam = [NSString stringWithFormat:@"{\"%@\":{\"read\":%@, \"write\":%@}, \"*\":{\"read\":%@}}", userID, @"true", @"true", @"true"];
    NSData *ACLData = [ACLParam dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *ACLDic = [NSJSONSerialization JSONObjectWithData:ACLData options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *authorDic = @{
                                @"__type": @"Pointer",
                                @"className": @"_User",
                                @"objectId": userID
                                };
    NSDictionary *groupDic = @{
                                @"__type": @"Pointer",
                                @"className": @"DLRSSGroup",
                                @"objectId": self.RSSGroup.rg_id
                                };
    NSString *feedUrl = [NSString stringWithFormat:@"http://%@", RSS];
    
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"classes/DLRSS";
        request.parameters = @{@"name":feedUrl, @"feedUrl":feedUrl, @"ACL":ACLDic, @"author":authorDic, @"group":groupDic};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } onFailure:^(NSError *error) {
        DDLogError(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        DDLogInfo(@"onFinished");
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
