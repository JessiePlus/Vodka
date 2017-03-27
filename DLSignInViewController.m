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

//自定义导航栏
@property (nonatomic) UINavigationBar *customNavigationBar;
@property (nonatomic) UINavigationItem *customNavigationItem;

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customNavigationBar];
    
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.wechatBtn];
    [self.view addSubview:self.weiboBtn];
    
    //导航栏布局
    [self.customNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@64);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
    
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

-(UINavigationItem *)customNavigationItem {
    if (!_customNavigationItem) {
        _customNavigationItem = [[UINavigationItem alloc] initWithTitle:NSLocalizedString(@"Login", comment: "")];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 24, 24);
        [leftBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];

        
        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
        _customNavigationItem.leftBarButtonItems = @[leftBarBtn];
        
    }
    
    return _customNavigationItem;
}

-(UINavigationBar *)customNavigationBar {
    if (!_customNavigationBar) {
        _customNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        [_customNavigationBar setItems:@[self.customNavigationItem] animated:false];
        _customNavigationBar.barTintColor = [UIColor whiteColor];
        _customNavigationBar.titleTextAttributes = @{
                                                     NSForegroundColorAttributeName:[UIColor blackColor]
                                                     
                                                     };
    }
    
    return _customNavigationBar;
}

-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor grayColor];
        _titleLab.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightThin];
        _titleLab.text = NSLocalizedString(@"Thirdpart account login", comment: "");
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
