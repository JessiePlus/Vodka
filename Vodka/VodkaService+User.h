//
//  VodkaService+User.h
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "VodkaService.h"
#import "User.h"
#import "MobilePhone.h"

@interface VodkaService (User)


-(void)requestSendVerifyCodeOfMobilePhone:(MobilePhone *)mobilePhone
                                  success:(void (^)(void))success
                                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

-(void)loginByMobilePhone:(MobilePhone *)mobilePhone
           withVerifyCode:(NSString *)verifyCode
                  success:(void (^)(User *))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
