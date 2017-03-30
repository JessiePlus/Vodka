//
//  DLRSS.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLRSS : NSObject

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSDate *updatedAt;


@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSURL *imageUrl;

@end
