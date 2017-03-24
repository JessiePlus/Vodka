//
//  DiscoverViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//
#import <WeexSDK/WXSDKInstance.h>
#import <Masonry/Masonry.h>
#import <MapKit/MapKit.h>

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

//自定义导航栏
@property (nonatomic) UINavigationBar *customNavigationBar;
@property (nonatomic) UINavigationItem *customNavigationItem;

@property (nonatomic) UIButton *locateBtn;

@property (nonatomic) MKMapView *mapView;

@end

@implementation DiscoverViewController

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.customNavigationBar];
    
    [self.view addSubview:self.mapView];
    
    [self.mapView addSubview:self.locateBtn];

    
    //导航栏布局
    [self.customNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@64);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64-49);
        make.top.equalTo(self.customNavigationBar.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    
    [self.locateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@32);
        make.height.equalTo(@32);
        make.bottom.equalTo(self.mapView).offset(-60);
        make.left.equalTo(self.mapView).offset(10);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UINavigationItem *)customNavigationItem {
    if (!_customNavigationItem) {
        _customNavigationItem = [[UINavigationItem alloc] initWithTitle:NSLocalizedString(@"Discover", comment: "")];
        
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

-(MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        _mapView.showsUserLocation = YES;

    }

    return _mapView;
}

-(UIButton *)locateBtn {
    if (!_locateBtn) {
        _locateBtn = [[UIButton alloc] init];
        [_locateBtn setImage:[UIImage imageNamed:@"icon_locate"] forState:UIControlStateNormal];
        
    }
    
    return _locateBtn;
}


@end
