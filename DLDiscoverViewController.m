//
//  DiscoverViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//
#import <Masonry/Masonry.h>

#import "DLDiscoverViewController.h"

@interface DLDiscoverViewController ()


@end

@implementation DLDiscoverViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        
        
        NSLog(@"DiscoverViewController init");
        
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"DiscoverViewController dealloc");
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Discover", comment: "");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
