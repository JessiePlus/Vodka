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
    
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Add RSS", comment: "");
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBtnClicked)];
    
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
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
