//
//  DLFeedItem.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLFeedItem : NSObject

@property (nonatomic, copy) NSString *title;
//unique
@property (nonatomic, copy) NSString *link;
@property (nonatomic) NSDate *date;

@property (nonatomic, copy) NSString *content;

@end
