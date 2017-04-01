//
//  DLFeedViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/30.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLFeedViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>
#import "AppUtil.h"


@interface DLFeedViewController ()
@property (strong,nonatomic) WKWebView *webView;

@end

@implementation DLFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏
    self.navigationItem.title = _feedItem.title;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 24, 24);
    [leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[leftBarBtn];
    
    _webView = [[WKWebView alloc] init];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self loadContent];

    
}

- (void)loadContent{
    NSString *postString = [self readResourceContent:@"post.html"];
    NSString *content = _feedItem.content;
    NSString *htmlContent = [NSString stringWithFormat:postString,
                             [self readResourceContent:@"bootstrap.min.css"],
                             [self readResourceContent:@"font-awesome.min.css"],
                             [self readResourceContent:@"main.css"],
                             _feedItem.title,
                             content];
    [_webView loadHTMLString:htmlContent baseURL:nil];
}

- (NSString *)readResourceContent:(NSString*)name{
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
    NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if(!string)return @"";
    return string;
}

-(void)leftBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
