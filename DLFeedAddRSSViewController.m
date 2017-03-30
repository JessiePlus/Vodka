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

@end

@implementation DLFeedAddRSSViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"DLFeedAddRSSViewController init");
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"DLFeedAddRSSViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Add RSS", comment: "");
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 24, 24);
    [leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[leftBarBtn];
    
}

-(void)leftBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClicked {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
