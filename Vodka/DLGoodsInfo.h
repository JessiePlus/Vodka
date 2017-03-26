//
//  DLGoodsInfo.h
//  Vodka
//
//  Created by dinglin on 2017/3/25.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLGoodsInfo : NSObject
@property (nonatomic, assign) int mid;

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSURL *imageUrl;


@property (nonatomic, copy) NSString *infoTitle1;
@property (nonatomic, copy) NSString *infoTitle2;
@property (nonatomic, copy) NSString *infoTitle3;
@property (nonatomic, copy) NSString *infoTitle4;

@property (nonatomic, copy) NSString *infoContent1;
@property (nonatomic, copy) NSString *infoContent2;
@property (nonatomic, copy) NSString *infoContent3;
@property (nonatomic, copy) NSString *infoContent4;

@end
