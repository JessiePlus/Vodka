//
//  DLFeedEditViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/26.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedAddRSSViewController.h"
#import <Masonry.h>

@interface DLFeedAddRSSViewController ()
@property (nonatomic) UITextField *RSSTF;
@property (nonatomic) UILabel *httpLab;//手机号

@end

@implementation DLFeedAddRSSViewController

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
    }
    
    return _RSSTF;
}



-(void)rightBtnClicked {
    NSString *RSS = self.RSSTF.text;
    if (!RSS || RSS.length == 0) {
        return;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
