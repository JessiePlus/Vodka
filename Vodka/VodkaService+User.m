//
//  VodkaService+User.m
//  Vodka
//
//  Created by dinglin on 2017/3/5.
//  Copyright © 2017年 dinglin. All rights reserved.
//

#import "VodkaService+User.h"
#import <AFNetworking.h>


@implementation VodkaService (User)


-(void)requestSendVerifyCodeOfMobilePhone:(MobilePhone *)mobilePhone
                                  success:(void (^)(void))success
                                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    NSDictionary *requestParameters = @{
        @"mobilePhoneNumber":mobilePhone.number
    };
    
    NSString *path = @"/1.1/requestSmsCode";

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.apiBaseUrl];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"x6XqOXajuBXl7KAPgkDGVm2v-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:@"HlGlENGF6ki2CL32REOskquL" forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager POST:path
       parameters:requestParameters
         progress:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {

              
    }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
          
          }];
    
}

-(void)loginByMobilePhone:(MobilePhone *)mobilePhone
           withVerifyCode:(NSString *)verifyCode
                  success:(void (^)(User *))success
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSDictionary *requestParameters = @{
                                        @"mobilePhoneNumber":mobilePhone.number,
                                        @"smsCode":verifyCode
                                        };
    
    NSString *path = @"/1.1/usersByMobilePhone";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.apiBaseUrl];
    [manager POST:path parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *name = responseObject[@"name"];
        NSString *city = responseObject[@"city"];
        
        User *user = [User userWithName:name andCity:city];
        success(user);
        
        
        
    } failure:failure];


}


@end
