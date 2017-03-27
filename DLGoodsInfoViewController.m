//
//  DLGoodsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLGoodsInfoViewController.h"
#import <Masonry.h>
#import "GoodsInfoCell.h"
#import "GoodsInfoHeaderCell.h"
#import "LoginViewController.h"
#import "DLGoodsInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TableSectionTitleView.h"
#import <XMNetworking/XMNetworking.h>

static NSString *const kGoodsInfoCell = @"GoodsInfoCell";
static NSString *const kGoodsInfoHeaderCell = @"kGoodsInfoHeaderCell";


static NSString *const kTableSectionTitleView = @"TableSectionTitleView";

@interface DLGoodsInfoViewController () <UITableViewDelegate, UITableViewDataSource>

//自定义导航栏
@property (nonatomic) UINavigationBar *customNavigationBar;
@property (nonatomic) UINavigationItem *customNavigationItem;

//用户信息列表
@property (nonatomic) UITableView *userInfoListView;

@property (nonatomic) DLGoodsInfo *goodsInfo;

//计算高度
@property (nonatomic, strong) UITableViewCell *templateCell;


@end

@implementation DLGoodsInfoViewController

-(instancetype)init {
    self = [super init];
    if (self) {
        
        
        NSLog(@"DLGoodsViewController init");
        
    }
    
    return self;
}

-(void)dealloc {
    NSLog(@"DLGoodsViewController dealloc");
    
    
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
    [self.view addSubview:self.userInfoListView];
    
    
    //导航栏布局
    [self.customNavigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@64);
        make.top.equalTo(@0);
        make.left.equalTo(@0);
    }];
    
    [self.userInfoListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.customNavigationBar.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    
    
    self.userInfoListView.backgroundColor = [UIColor whiteColor];
    
    self.userInfoListView.dataSource = self;
    self.userInfoListView.delegate = self;
    
    
    self.templateCell = [self.userInfoListView dequeueReusableCellWithIdentifier:kGoodsInfoCell];
    
    //请求商品的信息
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"classes/GoodsInfo/58d7da705c497d0057fe237f";
        request.parameters = @{};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodGET;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {
        NSLog(@"onSuccess: %@", responseObject);
    } onFailure:^(NSError *error) {
        NSLog(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        NSLog(@"onFinished");
    }];

    
}

-(UINavigationItem *)customNavigationItem {
    if (!_customNavigationItem) {
        _customNavigationItem = [[UINavigationItem alloc] init];

        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 24, 24);
        [leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        
        
        _customNavigationItem.leftBarButtonItems = @[leftBarBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 24, 24);
        [rightBtn setImage:[UIImage imageNamed:@"icon_shareArticle"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        
        
        _customNavigationItem.rightBarButtonItems = @[rightBarBtn];
        
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

-(UITableView *)userInfoListView {
    if (!_userInfoListView) {
        _userInfoListView = [[UITableView alloc] initWithFrame:CGRectZero];
        _userInfoListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_userInfoListView registerClass:[GoodsInfoCell class] forCellReuseIdentifier:kGoodsInfoCell];
        [_userInfoListView registerClass:[GoodsInfoHeaderCell class] forCellReuseIdentifier:kGoodsInfoHeaderCell];
        
        [_userInfoListView registerClass:[TableSectionTitleView class] forHeaderFooterViewReuseIdentifier:kTableSectionTitleView];
    }
    
    
    return _userInfoListView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        return 100;
    }
    
    
    if (section == 1) {
        GoodsInfoCell *cell = (GoodsInfoCell *)self.templateCell;
        
        cell.titleLab.text = self.goodsInfo.infoContent1;
       CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
        
        return cellHeight;
    }
    if (section == 2) {
        GoodsInfoCell *cell = (GoodsInfoCell *)self.templateCell;
        
        cell.titleLab.text = self.goodsInfo.infoContent2;
        CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
        
        return cellHeight;
    }
    if (section == 3) {
        GoodsInfoCell *cell = (GoodsInfoCell *)self.templateCell;
        
        cell.titleLab.text = self.goodsInfo.infoContent3;
        CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
        
        return cellHeight;
    }
    if (section == 4) {
        GoodsInfoCell *cell = (GoodsInfoCell *)self.templateCell;
        
        cell.titleLab.text = self.goodsInfo.infoContent4;
        CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
        
        return cellHeight;
    }
    
    return 60;



}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        switch (row) {
            case 0:
            {
                GoodsInfoHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoHeaderCell forIndexPath:indexPath];

                [cell.iconImageView sd_setImageWithURL:self.goodsInfo.imageUrl placeholderImage:[UIImage imageNamed:@""]];
                [cell.titleLab setText:self.goodsInfo.name];
                
                
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    
    if (section == 1) {
        
        switch (row) {
            case 0:
            {
                GoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoCell forIndexPath:indexPath];
                [cell.titleLab setText:self.goodsInfo.infoContent1];
                
                return cell;
            }
                break;
            default:
                break;
        }
    }
    
    if (section == 2) {
        
        switch (row) {
            case 0:
            {
                GoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoCell forIndexPath:indexPath];
                [cell.titleLab setText:self.goodsInfo.infoContent2];
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    
    if (section == 3) {
        
        switch (row) {
            case 0:
            {
                GoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoCell forIndexPath:indexPath];
                [cell.titleLab setText:self.goodsInfo.infoContent3];
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    if (section == 4) {
        
        switch (row) {
            case 0:
            {
                GoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoCell forIndexPath:indexPath];
                [cell.titleLab setText:self.goodsInfo.infoContent4];
                
                return cell;
            }
                break;
                
            default:
                break;
        }
    }
    
    
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
        case 2:
        case 3:
        case 4:
        {
            TableSectionTitleView *sectionTitleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kTableSectionTitleView];
            
            
            if (section == 1) {
                sectionTitleView.titleLab.text = self.goodsInfo.infoTitle1;
            }
            if (section == 2) {
                sectionTitleView.titleLab.text = self.goodsInfo.infoTitle2;
                
            }
            if (section == 3) {
                sectionTitleView.titleLab.text = self.goodsInfo.infoTitle3;
                
            }
            if (section == 4) {
                sectionTitleView.titleLab.text = self.goodsInfo.infoTitle4;
                
            }
        
            return sectionTitleView;

        }
 
            break;
            
        default:
        {
        
            return nil;
        
        }
            break;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    
    return 20;
    
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
