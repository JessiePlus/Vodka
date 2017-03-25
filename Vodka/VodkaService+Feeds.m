//
//  VodkaService+Feeds.m
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "VodkaService+Feeds.h"
#import <AFNetworking.h>

@implementation VodkaService (Feeds)

-(void)requestAllFeedsSuccess:(void (^)(NSArray <DLFeed *>*))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSString *path = @"/1.1/classes/Feeds";
    
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
            NSString *nickName = goodsDic[@"nickName"];
            NSString *msgContent = goodsDic[@"msgContent"];
            NSString *avatarImageUrl = goodsDic[@"avatarImageUrl"];
            
            DLFeed *goodsCategories = [[DLFeed alloc] init];
            goodsCategories.objectId = objectId;
            goodsCategories.nickName = nickName;
            goodsCategories.msgContent = msgContent;
            goodsCategories.avatarImageUrl = [NSURL URLWithString:avatarImageUrl];
            
            [goodsCategoriesList addObject:goodsCategories];
        }
        
        success(goodsCategoriesList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];





}


@end
