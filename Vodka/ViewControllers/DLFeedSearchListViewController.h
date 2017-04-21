//
//  DLFeedSearchListViewController.h
//  Vodka
//
//  Created by dinglin on 2017/4/21.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "DLBaseViewController.h"
#import "DLFeedItem.h"

@interface DLFeedSearchListViewController : DLBaseViewController
//用户信息列表
@property (nonatomic) UITableView *feedsListView;
@property (nonatomic) NSMutableArray <DLFeedItem *> *feedItemList;

@end
