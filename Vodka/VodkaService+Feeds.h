//
//  VodkaService+Feeds.h
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "VodkaService.h"
#import "DLFeed.h"


@interface VodkaService (Feeds)

-(void)requestAllFeedsSuccess:(void (^)(NSArray <DLFeed *>*))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;



@end
