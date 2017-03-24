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

@end
