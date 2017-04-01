//
//  DLRSS.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@protocol DLRSS;

@interface DLRSS : JSONModel

//对象编号
@property (nonatomic, copy) NSString *objectId;

@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSDate *updatedAt;

//RSS所属的分组表
@property (nonatomic, copy) NSString <Ignore>*RSSGroupID;

//RSS的名称
@property (nonatomic, copy) NSString *name;
//RSS的图标
@property (nonatomic) NSURL *iconUrl;
//RSS的订阅链接
@property (nonatomic) NSURL *feedUrl;
//RSS的访问链接
@property (nonatomic) NSURL *url;


@end
