//
//  DLFeed.h
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@interface DLFeed : NSObject

@property (nonatomic, copy) NSString<Optional> *title;        //名称
@property (nonatomic, copy) NSString<Optional> *link;         //博客链接
@property (nonatomic, copy) NSString<Optional> *des;          //简介
@property (nonatomic, copy) NSString<Optional> *copyright;
@property (nonatomic, copy) NSString<Optional> *generator;
@property (nonatomic, copy) NSString<Optional> *imageUrl;     //icon图标
@property (nonatomic, strong) NSMutableArray *items;          //SMFeedItemModel
@property (nonatomic, copy) NSString<Optional> *feedUrl;      //博客feed的链接

@end

