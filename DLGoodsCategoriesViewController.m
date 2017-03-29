//
//  GoodsCategoriesViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLGoodsCategoriesViewController.h"
#import <Masonry/Masonry.h>
#import "DLGoodsCategoriesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "DLGoodsInfoViewController.h"
#import <XMNetworking/XMNetworking.h>

#import "DLGoodsCategories.h"


static NSString *const kGoodsCateroriesCell = @"GoodsCateroriesCell";


@interface DLGoodsCategoriesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) UICollectionView *goodsCategoriesListView;
@property (nonatomic, copy) NSMutableArray <DLGoodsCategories *>*goodsCategoriesList;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self.view addSubview:self.goodsCategoriesListView];
    
    
    self.goodsCategoriesListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self.goodsCategoriesListView.mj_header endRefreshing];
        
    }];
    
    //导航栏
    self.navigationItem.title = NSLocalizedString(@"Goods", comment: "");

    
    [self.goodsCategoriesListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.view);
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


-(UICollectionView *)goodsCategoriesListView {
    if (!_goodsCategoriesListView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(90, 90);
        
        _goodsCategoriesListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _goodsCategoriesListView.backgroundColor = [UIColor whiteColor];
        
        _goodsCategoriesListView.delegate = self;
        _goodsCategoriesListView.dataSource = self;
        
        [_goodsCategoriesListView registerClass:[DLGoodsCategoriesCell class] forCellWithReuseIdentifier:kGoodsCateroriesCell];
    }
    
    
    return _goodsCategoriesListView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    NSInteger index = indexPath.item;
    
    
    DLGoodsCategoriesCell *goodsCateroriesCell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsCateroriesCell forIndexPath:indexPath];

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
