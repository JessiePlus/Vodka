//
//  DLGoodsViewController.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLGoodsInfoViewController.h"
#import <Masonry.h>
#import "DLGoodsInfoCell.h"
#import "DLGoodsInfoHeaderCell.h"
#import "DLSignInViewController.h"
#import "DLGoodsInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DLGoodsInfoSectionTitleView.h"
#import <XMNetworking/XMNetworking.h>

static NSString *const kGoodsInfoCell = @"GoodsInfoCell";
static NSString *const kGoodsInfoHeaderCell = @"kGoodsInfoHeaderCell";


static NSString *const kTableSectionTitleView = @"TableSectionTitleView";

@interface DLGoodsInfoViewController () <UITableViewDelegate, UITableViewDataSource>

//用户信息列表
@property (nonatomic) UITableView *goodsInfoListView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.goodsInfoListView];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 24, 24);
    [leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItems = @[leftBarBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 24, 24);
    [rightBtn setImage:[UIImage imageNamed:@"icon_shareArticle"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItems = @[rightBarBtn];
    
    
    [self.goodsInfoListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).offset(-64);
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    
    self.goodsInfoListView.backgroundColor = [UIColor whiteColor];
    
    self.goodsInfoListView.dataSource = self;
    self.goodsInfoListView.delegate = self;
    
    
    self.templateCell = [self.goodsInfoListView dequeueReusableCellWithIdentifier:kGoodsInfoCell];
    
    //请求商品的信息
    [XMCenter sendRequest:^(XMRequest *request) {
        request.api = @"classes/GoodsInfo/58d7da705c497d0057fe237f";
        request.parameters = @{};
        request.headers = @{};
        request.httpMethod = kXMHTTPMethodGET;
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id responseObject) {

        NSDictionary *goodsDic = responseObject;
        
        
        NSString *objectId = goodsDic[@"objectId"];
        NSString *name = goodsDic[@"name"];
        NSString *imageUrl = goodsDic[@"image"];
        
        NSString *infoTitle1 = goodsDic[@"title1"];
        NSString *infoTitle2 = goodsDic[@"title2"];
        NSString *infoTitle3 = goodsDic[@"title3"];
        NSString *infoTitle4 = goodsDic[@"title4"];
        
        NSString *infoContent1 = goodsDic[@"content1"];
        NSString *infoContent2 = goodsDic[@"content2"];
        NSString *infoContent3 = goodsDic[@"content3"];
        NSString *infoContent4 = goodsDic[@"content4"];
        
        
        DLGoodsInfo *goodsInfo = [[DLGoodsInfo alloc] init];
        goodsInfo.objectId = objectId;
        goodsInfo.name = name;
        goodsInfo.imageUrl = [NSURL URLWithString:imageUrl];
        
        goodsInfo.infoTitle1 = infoTitle1;
        goodsInfo.infoTitle2 = infoTitle2;
        goodsInfo.infoTitle3 = infoTitle3;
        goodsInfo.infoTitle4 = infoTitle4;
        
        goodsInfo.infoContent1 = infoContent1;
        goodsInfo.infoContent2 = infoContent2;
        goodsInfo.infoContent3 = infoContent3;
        goodsInfo.infoContent4 = infoContent4;
        
        self.goodsInfo = goodsInfo;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.goodsInfoListView reloadData];
        });
    
    } onFailure:^(NSError *error) {
        NSLog(@"onFailure: %@", error);
    } onFinished:^(id responseObject, NSError *error) {
        NSLog(@"onFinished");
    }];

    
}

-(UITableView *)goodsInfoListView {
    if (!_goodsInfoListView) {
        _goodsInfoListView = [[UITableView alloc] initWithFrame:CGRectZero];
        _goodsInfoListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_goodsInfoListView registerClass:[DLGoodsInfoCell class] forCellReuseIdentifier:kGoodsInfoCell];
        [_goodsInfoListView registerClass:[DLGoodsInfoHeaderCell class] forCellReuseIdentifier:kGoodsInfoHeaderCell];
        
        [_goodsInfoListView registerClass:[DLGoodsInfoSectionTitleView class] forHeaderFooterViewReuseIdentifier:kTableSectionTitleView];
    }
    
    
    return _goodsInfoListView;
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
        DLGoodsInfoCell *cell = (DLGoodsInfoCell *)self.templateCell;
        
        cell.titleLab.text = self.goodsInfo.infoContent1;
       CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
        
        return cellHeight;
    }
    if (section == 2) {
        DLGoodsInfoCell *cell = (DLGoodsInfoCell *)self.templateCell;
        
        cell.titleLab.text = self.goodsInfo.infoContent2;
        CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
        
        return cellHeight;
    }
    if (section == 3) {
        DLGoodsInfoCell *cell = (DLGoodsInfoCell *)self.templateCell;
        
        cell.titleLab.text = self.goodsInfo.infoContent3;
        CGFloat cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;;
        
        return cellHeight;
    }
    if (section == 4) {
        DLGoodsInfoCell *cell = (DLGoodsInfoCell *)self.templateCell;
        
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
                DLGoodsInfoHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoHeaderCell forIndexPath:indexPath];

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
                DLGoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoCell forIndexPath:indexPath];
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
                DLGoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoCell forIndexPath:indexPath];
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
                DLGoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoCell forIndexPath:indexPath];
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
                DLGoodsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsInfoCell forIndexPath:indexPath];
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
            DLGoodsInfoSectionTitleView *sectionTitleView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kTableSectionTitleView];
            
            
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
