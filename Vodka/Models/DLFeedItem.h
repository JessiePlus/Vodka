//
//  DLFeedItem.h
//  Vodka
//
//  Created by DingLin on 17/4/1.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "JKDBModel.h"

@interface DLFeedItem : JKDBModel

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

//外键，feedInfo的id
@property (nonatomic, copy) NSString *fi_feedUrl_fk;

@end
