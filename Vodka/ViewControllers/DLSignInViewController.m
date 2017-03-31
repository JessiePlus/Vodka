//
//  LoginViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLSignInViewController.h"
#import <Masonry.h>


@interface DLSignInViewController ()

@property (nonatomic) UILabel *titleLab;

@property (nonatomic) UIButton *wechatBtn;
@property (nonatomic) UIButton *weiboBtn;

@end

@implementation DLSignInViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        
        
        NSLog(@"LoginViewController init");
        
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"LoginViewController dealloc");
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Sign in", comment: "");
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 24, 24);
    [leftBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItems = @[leftBarBtn];
    
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.wechatBtn];
    [self.view addSubview:self.weiboBtn];

    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@180);
        make.height.equalTo(@24);
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@32);
        make.height.equalTo(@32);
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_right).multipliedBy(0.33);
    }];
    
    [self.weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@32);
        make.height.equalTo(@32);
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_right).multipliedBy(0.66);
    }];
    
    [self.wechatBtn addTarget:self action:@selector(wechatBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.weiboBtn addTarget:self action:@selector(weiboBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor grayColor];
        _titleLab.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightThin];
        _titleLab.text = NSLocalizedString(@"Thirdpart account sign in", comment: "");
    }
    
    return _titleLab;
}

-(UIButton *)wechatBtn {
    if (!_wechatBtn) {
        _wechatBtn = [[UIButton alloc] init];
        [_wechatBtn setImage:[UIImage imageNamed:@"icon_wechat"] forState:UIControlStateNormal];

    }
    
    return _wechatBtn;
}

-(UIButton *)weiboBtn {
    if (!_weiboBtn) {
        _weiboBtn = [[UIButton alloc] init];
        [_weiboBtn setImage:[UIImage imageNamed:@"icon_weibo"] forState:UIControlStateNormal];
        
    }
    
    return _weiboBtn;
}

-(void)leftBtnClicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)wechatBtnClicked:(UIButton *)sender {
    
    
}

-(void)weiboBtnClicked:(UIButton *)sender {
    
    
}

@end