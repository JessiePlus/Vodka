//
//  VodkaService+Goods.m
//  Vodka
//
//  Created by dinglin on 2017/3/6.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "VodkaService+Goods.h"
#import <AFNetworking.h>

@implementation VodkaService (Goods)


-(void)requestAllGoodsSuccess:(void (^)(NSArray <DLGoods *>*))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSString *path = @"/1.1/classes/Goods";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.apiBaseUrl];
    
    [manager.requestSerializer setValue:@"x6XqOXajuBXl7KAPgkDGVm2v-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"HlGlENGF6ki2CL32REOskquL" forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *goodsDicList = responseObject[@"results"];
        
        NSMutableArray *goodsList = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < goodsDicList.count; i ++) {
            NSDictionary *goodsDic = goodsDicList[i];
            
            NSString *objectId = goodsDic[@"objectId"];
            NSString *name = goodsDic[@"name"];
            NSNumber *year = goodsDic[@"year"];
            NSString *country = goodsDic[@"country"];

            DLGoods *goods = [[DLGoods alloc] init];
            goods.objectId = objectId;
            goods.name = name;
            goods.year = [year intValue];
            goods.country = country;
            
            [goodsList addObject:goods];
        }
        
        success(goodsList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

-(void)requestAllGoodsCategoriesSuccess:(void (^)(NSArray <DLGoodsCategories *>*))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = @"/1.1/classes/GoodsCategories";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.apiBaseUrl];
    
    [manager.requestSerializer setValue:@"x6XqOXajuBXl7KAPgkDGVm2v-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"HlGlENGF6ki2CL32REOskquL" forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *goodsCategoriesDicList = responseObject[@"results"];
        
        NSMutableArray *goodsCategoriesList = [[NSMutableArray alloc] init];
        
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
            
            [goodsCategoriesList addObject:goodsCategories];
        }
        
        success(goodsCategoriesList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

-(void)requestGoodsInfoSuccess:(void (^)(DLGoodsInfo *))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = @"/1.1/classes/GoodsInfo/58d7da705c497d0057fe237f";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.apiBaseUrl];
    
    [manager.requestSerializer setValue:@"x6XqOXajuBXl7KAPgkDGVm2v-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"HlGlENGF6ki2CL32REOskquL" forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
        
        success(goodsInfo);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

@end
