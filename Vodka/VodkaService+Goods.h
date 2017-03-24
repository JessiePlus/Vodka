//
//  VodkaService+Goods.h
//  Vodka
//
//  Created by dinglin on 2017/3/6.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "VodkaService.h"
#import "DLGoods.h"
#import "DLGoodsCategories.h"


@interface VodkaService (Goods)

-(void)requestAllGoodsSuccess:(void (^)(NSArray <DLGoods *>*))success
                                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(void)requestAllGoodsCategoriesSuccess:(void (^)(NSArray <DLGoodsCategories *>*))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
