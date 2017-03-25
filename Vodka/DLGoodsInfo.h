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

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *descripText;
@property (nonatomic) NSURL *imageUrl;

@property (nonatomic, copy) NSString *producingArea;
@property (nonatomic, copy) NSString *brands;
@property (nonatomic, copy) NSString *productionProcess;
@property (nonatomic, copy) NSString *nutrition;

@end
