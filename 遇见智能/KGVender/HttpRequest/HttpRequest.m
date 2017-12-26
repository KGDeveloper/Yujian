//
//  HttpRequest.m
//  TableView
//
//  Created by Micheal on 15/7/13.
//  Copyright (c) 2015年 Micheal. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //    [manager.requestSerializer setValue:@"158b66b4b286369425de9be360a30ea0" forHTTPHeaderField:@"apikey"];
    
    // -- application/json 看情况使用这俩text/html
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil]];
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
