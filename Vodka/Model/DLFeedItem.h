//
//  DLFeedItem.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLFeedItem : NSObject

#if 0
//对象编号，主键，自增
@property (nonatomic, assign) NSUInteger mID;
#endif

//feedItem所属的feedInfo
@property (nonatomic, copy) NSString *feedInfoID;

@property (nonatomic, copy) NSString *title;
//unique
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *content;

@end
