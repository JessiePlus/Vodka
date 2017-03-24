//
//  DLGoods.h
//  Vodka
//
//  Created by dinglin on 2017/3/6.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLGoods : NSObject

@property (nonatomic, assign) int mid;

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int year;
@property (nonatomic, copy) NSString *country;

@end
