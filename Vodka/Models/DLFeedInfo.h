//
//  DLFeedInfo.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "LKDBModel.h"

@interface DLFeedInfo : LKDBModel

@property (nonatomic, assign) int pk_id;

@property (nonatomic, copy) NSString *feedUrl;

@property (nonatomic, copy) NSString *title;


@end
