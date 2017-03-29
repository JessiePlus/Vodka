//
//  DLRSS.h
//  Vodka
//
//  Created by dinglin on 2017/3/29.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLRSS : NSObject

@property (nonatomic, assign) int mid;

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *descripText;
@property (nonatomic) NSURL *imageUrl;

@end
