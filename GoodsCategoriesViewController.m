//
//  GoodsCategoriesViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/24.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "GoodsCategoriesViewController.h"
#import <Masonry/Masonry.h>
#import "GoodsCateroriesCell.h"
#import "VodkaService+Goods.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "DLGoodsInfoViewController.h"

static NSString *const kGoodsCateroriesCell = @"GoodsCateroriesCell";


@interface GoodsCategoriesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) UICollectionView *goodsCollectionView;


@property (nonatomic, copy) NSMutableArray *goodsCategoriesList;

//自定义导航栏
@property (nonatomic) UINavigationBar *customNavigationBar;
@property (nonatomic) UINavigationItem *customNavigationItem;

@end

@implementation GoodsCategoriesViewController

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
    [self.view addSubview:self.goodsCollectionView];
    
    
    self.goodsCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self.goodsCollectionView.mj_header endRefreshing];
        
    }];
    //导航栏布局
    [self.customNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@64);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
    
    [self.goodsCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.customNavigationBar.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    

    //请求茶种类
    
    [[VodkaService sharedManager] requestAllGoodsCategoriesSuccess:^(NSArray<DLGoodsCategories *> *goodsCategoriesList) {
        
        if (!_goodsCategoriesList) {
            _goodsCategoriesList = [[NSMutableArray alloc] init];
        } else {
            [_goodsCategoriesList removeAllObjects];
        }
        
        _goodsCategoriesList = [goodsCategoriesList mutableCopy];
        
        [self.goodsCollectionView reloadData];
   
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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


-(UICollectionView *)goodsCollectionView {
    if (!_goodsCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(90, 90);
        
        _goodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _goodsCollectionView.backgroundColor = [UIColor whiteColor];
        
        _goodsCollectionView.delegate = self;
        _goodsCollectionView.dataSource = self;
        
        [_goodsCollectionView registerClass:[GoodsCateroriesCell class] forCellWithReuseIdentifier:kGoodsCateroriesCell];
    }
    
    
    return _goodsCollectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    NSInteger index = indexPath.item;
    
    
    GoodsCateroriesCell *goodsCateroriesCell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsCateroriesCell forIndexPath:indexPath];

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
