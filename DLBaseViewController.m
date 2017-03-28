//
//  DLBaseViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/28.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLBaseViewController.h"

@interface DLBaseViewController ()

@end

@implementation DLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UINavigationController *navigationController = self.navigationController;
    
    if (!navigationController) {
        return;
    }
    
    navigationController.navigationBar.backgroundColor = nil;
    navigationController.navigationBar.translucent = YES;
    navigationController.navigationBar.shadowImage = nil;
    navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    navigationController.navigationBar.tintColor = nil;
    navigationController.navigationBar.titleTextAttributes = @{
                                                               NSForegroundColorAttributeName:[UIColor blackColor]
                                                               
                                                               };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
