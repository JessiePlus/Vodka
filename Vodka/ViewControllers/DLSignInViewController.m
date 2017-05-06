//
//  LoginViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLSignInViewController.h"
#import <Masonry.h>
#import <XMNetworking.h>
#import "VodkaUserDefaults.h"
#import "User.h"
#import <MJExtension.h>
#import "AppUtil.h"
#import <DLDBTool.h>

@interface DLSignInViewController ()


@property (nonatomic) UILabel *phoneLab;//手机号
@property (nonatomic) UILabel *verifCodeLab;//验证码

@property (nonatomic) UIButton *getVerifCodeBtn;//获取验证码
@property (nonatomic) UIButton *signInBtn;//登录
@property (nonatomic) UITextField *phoneTF;//手机号
@property (nonatomic) UITextField *verifCodeTF;//验证码

@end

@implementation DLSignInViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        DDLogInfo(@"LoginViewController init");
    }
    
    return self;
}

-(void)dealloc {
    DDLogInfo(@"LoginViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Sign in", comment: "");
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 24, 24);
    [leftBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItems = @[leftBarBtn];
    
    
    [self.view addSubview:self.phoneLab];
    [self.view addSubview:self.verifCodeLab];
    
    [self.view addSubview:self.getVerifCodeBtn];
    [self.view addSubview:self.signInBtn];
    [self.view addSubview:self.phoneTF];
    [self.view addSubview:self.verifCodeTF];

    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20);
        make.left.equalTo(self.view).offset(4);
        make.height.equalTo(@32);
        make.width.equalTo(@100);
    }];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLab);
        make.left.equalTo(self.phoneLab.mas_right);
        make.height.equalTo(@32);
        make.right.equalTo(self.getVerifCodeBtn.mas_left);
    }];
    [self.getVerifCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLab);
        make.right.equalTo(self.view).offset(-4);
        make.height.equalTo(@32);
        make.width.equalTo(@100);
    }];
    
    
    [self.verifCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLab.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(4);
        make.height.equalTo(@32);
        make.width.equalTo(@100);
    }];
    
    [self.verifCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifCodeLab);
        make.left.equalTo(self.verifCodeLab.mas_right);
        make.height.equalTo(@32);
        make.width.equalTo(self.phoneTF);
    }];

    
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifCodeTF.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);

    }];
    
    [self.getVerifCodeBtn addTarget:self action:@selector(getVerifCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.signInBtn addTarget:self action:@selector(signInBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.phoneTF becomeFirstResponder];
    
}

-(UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc] init];
        _phoneLab.backgroundColor = [UIColor whiteColor];
        _phoneLab.text = NSLocalizedString(@"Phone number", comment: "");
    }
    return _phoneLab;
}

-(UILabel *)verifCodeLab {
    if (!_verifCodeLab) {
        _verifCodeLab = [[UILabel alloc] init];
        _verifCodeLab.backgroundColor = [UIColor whiteColor];
        _verifCodeLab.text = NSLocalizedString(@"Verified code", comment: "");
    }
    return _verifCodeLab;
}

-(UITextField *)phoneTF {
    if (!_phoneTF) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.textAlignment = NSTextAlignmentCenter;
        _phoneTF.placeholder = NSLocalizedString(@"Input phone number", comment: "");
        _phoneTF.backgroundColor = [UIColor whiteColor];
    }
    
    return _phoneTF;
}

-(UITextField *)verifCodeTF {
    if (!_verifCodeTF) {
        _verifCodeTF = [[UITextField alloc] init];
        _verifCodeTF.textAlignment = NSTextAlignmentCenter;
        _verifCodeTF.placeholder = NSLocalizedString(@"Input verified code", comment: "");
        _verifCodeTF.backgroundColor = [UIColor whiteColor];
    }
    
    return _verifCodeTF;
}

-(UIButton *)getVerifCodeBtn {
    if (!_getVerifCodeBtn) {
        _getVerifCodeBtn = [[UIButton alloc] init];
        [_getVerifCodeBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_getVerifCodeBtn setTitle:NSLocalizedString(@"Get verify code", comment: "") forState:UIControlStateNormal];

    }
    
    return _getVerifCodeBtn;
}

-(UIButton *)signInBtn {
    if (!_signInBtn) {
        _signInBtn = [[UIButton alloc] init];
        _signInBtn.backgroundColor = [UIColor darkGrayColor];
        [_signInBtn setTitle:NSLocalizedString(@"Sign in", comment: "") forState:UIControlStateNormal];
        
    }
    
    return _signInBtn;
}

-(void)leftBtnClicked {
    
    [self.phoneTF resignFirstResponder];
    [self.verifCodeTF resignFirstResponder];
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getVerifCodeBtnClicked:(UIButton *)sender {
    
    NSString *phoneNum = self.phoneTF.text;
    if (!phoneNum || phoneNum.length == 0) {
        return;
    }
    
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"requestSmsCode";
        request.parameters = @{@"mobilePhoneNumber": phoneNum};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {
        
        [self.getVerifCodeBtn setTitle:NSLocalizedString(@"Verified code has been sent", comment: "") forState:UIControlStateNormal];
        
    } onFailure:^(NSError *error) {
        DDLogError(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        DDLogInfo(@"onFinished");
    }];
    
    
}

-(void)signInBtnClicked:(UIButton *)sender {
    
    NSString *phoneNum = self.phoneTF.text;
    if (!phoneNum || phoneNum.length == 0) {
        return;
    }
    
    NSString *verifCode = self.verifCodeTF.text;
    if (!verifCode || verifCode.length == 0) {
        return;
    }
    
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"usersByMobilePhone";
        request.parameters = @{@"mobilePhoneNumber": phoneNum, @"smsCode":verifCode};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {
        [User mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"userID" : @"objectId",
                     @"name" : @"username",
                     @"accessToken" : @"sessionToken"
                     };
        }];
        
        User *loginUser = [User mj_objectWithKeyValues:responseObject];

        VodkaUserDefaults *userDefaults= [VodkaUserDefaults sharedUserDefaults];
        [userDefaults setUserID:loginUser.userID];
        [userDefaults setName:loginUser.name];
        [userDefaults setAccessToken:loginUser.accessToken];
        
        [[DLDBTool shareInstance] changeDBWithDirectoryName:loginUser.userID];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:[AppUtil notificationNameSignIn] object:nil userInfo:nil];

  
        [self leftBtnClicked];
        
    } onFailure:^(NSError *error) {
        DDLogError(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        DDLogInfo(@"onFinished");
    }];
    
}

@end
