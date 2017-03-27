//
//  GoodsCategoriesViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLGoodsCategoriesViewController.h"
#import <Masonry/Masonry.h>
#import "DLGoodsCateroriesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "DLGoodsInfoViewController.h"
#import <XMNetworking/XMNetworking.h>

#import "DLGoodsCategories.h"


static NSString *const kGoodsCateroriesCell = @"GoodsCateroriesCell";


@interface DLGoodsCategoriesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) UICollectionView *goodsCategoriesListView;
@property (nonatomic, copy) NSMutableArray <DLGoodsCategories *>*goodsCategoriesList;

//自定义导航栏
@property (nonatomic) UINavigationBar *customNavigationBar;
@property (nonatomic) UINavigationItem *customNavigationItem;

@end

@implementation DLGoodsCategoriesViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        
        
        NSLog(@"GoodsCategoriesViewController init");
        
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"GoodsCategoriesViewController dealloc");
    
    
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
    [self.view addSubview:self.goodsCategoriesListView];
    
    
    self.goodsCategoriesListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self.goodsCategoriesListView.mj_header endRefreshing];
        
    }];
    //导航栏布局
    [self.customNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@64);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
    
    [self.goodsCategoriesListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.customNavigationBar.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    

    if (!_goodsCategoriesList) {
        _goodsCategoriesList = [[NSMutableArray alloc] init];
    }
    
    //请求商品的种类
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"classes/GoodsCategories";
        request.parameters = @{};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodGET;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {

        NSArray *goodsCategoriesDicList = responseObject[@"results"];
        
        for (NSInteger i = 0; i < goodsCategoriesDicList.count; i ++) {
            NSDictionary *goodsDic = goodsCategoriesDicList[i];
            
            NSString *objectId = goodsDic[@"objectId"];
            NSString *title = goodsDic[@"title"];
            NSString *discrip = goodsDic[@"description"];
            NSString *imageUrl = goodsDic[@"image"];
            
            DLGoodsCategories *goodsCategories = [[DLGoodsCategories alloc] init];
            goodsCategories.objectId = objectId;
            goodsCategories.title = title;
            goodsCategories.descripText = discrip;
            goodsCategories.imageUrl = [NSURL URLWithString:imageUrl];
            
            [self.goodsCategoriesList addObject:goodsCategories];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.goodsCategoriesListView reloadData];
            });
        }
    
    
    
    
    
    } onFailure:^(NSError *error) {
        NSLog(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        NSLog(@"onFinished");
    }];

    
    
}


-(UINavigationItem *)customNavigationItem {
    if (!_customNavigationItem) {
        _customNavigationItem = [[UINavigationItem alloc] initWithTitle:NSLocalizedString(@"Goods", comment: "")];
        
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


-(UICollectionView *)goodsCategoriesListView {
    if (!_goodsCategoriesListView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(90, 90);
        
        _goodsCategoriesListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _goodsCategoriesListView.backgroundColor = [UIColor whiteColor];
        
        _goodsCategoriesListView.delegate = self;
        _goodsCategoriesListView.dataSource = self;
        
        [_goodsCategoriesListView registerClass:[DLGoodsCateroriesCell class] forCellWithReuseIdentifier:kGoodsCateroriesCell];
    }
    
    
    return _goodsCategoriesListView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    NSInteger index = indexPath.item;
    
    
    DLGoodsCateroriesCell *goodsCateroriesCell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsCateroriesCell forIndexPath:indexPath];

    DLGoodsCategories *goodsCategories = self.goodsCategoriesList[index];

    
    [goodsCateroriesCell.iconImageView sd_setImageWithURL:goodsCategories.imageUrl placeholderImage:[UIImage imageNamed:@""]];
    [goodsCateroriesCell.titleLab setText:goodsCategories.title];

    return goodsCateroriesCell;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsCategoriesList.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger section = indexPath.section;
    NSInteger item = indexPath.item;
    
    
    DLGoodsInfoViewController *goodsInfoViewController = [[DLGoodsInfoViewController alloc] init];
    
    goodsInfoViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodsInfoViewController animated:YES];




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
